#include "MusicController.h"
#include <QDebug>

MusicController::MusicController(QObject *parent)
    : QObject(parent)
    , m_player(new QMediaPlayer(this))
    , m_audioOutput(new QAudioOutput(this))
    , m_currentIndex(0)
    , m_isPlaying(false)
    , m_volume(50)
{
    m_player->setAudioOutput(m_audioOutput);
    m_audioOutput->setVolume(m_volume / 100.0);

    connect(m_player, &QMediaPlayer::playbackStateChanged,
            this, &MusicController::onPlaybackStateChanged);
    connect(m_player, &QMediaPlayer::durationChanged,
            this, &MusicController::onDurationChanged);
    connect(m_player, &QMediaPlayer::positionChanged,
            this, &MusicController::onPositionChanged);
    connect(m_player, &QMediaPlayer::mediaStatusChanged,
            this, &MusicController::onMediaStatusChanged);

    loadPlaylist();

    if (!m_playlist.isEmpty()) {
        playTrackAt(0);
    }
}

MusicController::~MusicController()
{
    delete m_audioOutput;
    delete m_player;
}

void MusicController::loadPlaylist()
{
    // Add sample tracks - you can modify this to load from a directory or file
    m_playlist << "qrc:/music/track1.mp3"
               << "qrc:/music/track2.mp3"
               << "qrc:/music/track3.mp3";

    m_trackTitles << "Electric Dreams"
                  << "Highway Cruise"
                  << "Future Roads";

    m_trackArtists << "Tesla Sound"
                   << "Auto Beat"
                   << "Drive Mode";

    emit playlistChanged();
}

void MusicController::updateTrackInfo()
{
    emit currentTrackChanged();
}

QString MusicController::currentTrackTitle() const
{
    if (m_currentIndex >= 0 && m_currentIndex < m_trackTitles.count()) {
        return m_trackTitles[m_currentIndex];
    }
    return "No Track";
}

QString MusicController::currentArtist() const
{
    if (m_currentIndex >= 0 && m_currentIndex < m_trackArtists.count()) {
        return m_trackArtists[m_currentIndex];
    }
    return "Unknown Artist";
}

qint64 MusicController::duration() const
{
    return m_player->duration();
}

qint64 MusicController::position() const
{
    return m_player->position();
}

void MusicController::playPause()
{
    if (m_player->playbackState() == QMediaPlayer::PlayingState) {
        m_player->pause();
    } else {
        m_player->play();
    }
}

void MusicController::next()
{
    if (m_playlist.isEmpty()) return;

    m_currentIndex = (m_currentIndex + 1) % m_playlist.count();
    playTrackAt(m_currentIndex);
}

void MusicController::previous()
{
    if (m_playlist.isEmpty()) return;

    m_currentIndex = (m_currentIndex - 1 + m_playlist.count()) % m_playlist.count();
    playTrackAt(m_currentIndex);
}

void MusicController::seek(qint64 position)
{
    m_player->setPosition(position);
}

void MusicController::setVolume(int volume)
{
    if (m_volume == volume) return;

    m_volume = qBound(0, volume, 100);
    m_audioOutput->setVolume(m_volume / 100.0);
    emit volumeChanged();
}

void MusicController::playTrackAt(int index)
{
    if (index < 0 || index >= m_playlist.count()) return;

    m_currentIndex = index;
    m_player->setSource(QUrl(m_playlist[m_currentIndex]));
    m_player->play();
    updateTrackInfo();
}

void MusicController::onPlaybackStateChanged(QMediaPlayer::PlaybackState state)
{
    bool wasPlaying = m_isPlaying;
    m_isPlaying = (state == QMediaPlayer::PlayingState);

    if (wasPlaying != m_isPlaying) {
        emit isPlayingChanged();
    }
}

void MusicController::onDurationChanged(qint64 duration)
{
    emit durationChanged();
}

void MusicController::onPositionChanged(qint64 position)
{
    emit positionChanged();
}

void MusicController::onMediaStatusChanged(QMediaPlayer::MediaStatus status)
{
    // Auto-play next track when current one ends
    if (status == QMediaPlayer::EndOfMedia) {
        next();
    }
}
