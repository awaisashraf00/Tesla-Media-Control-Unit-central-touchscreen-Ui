#ifndef MUSICCONTROLLER_H
#define MUSICCONTROLLER_H

#include <QObject>
#include <QString>
#include <QStringList>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QUrl>

class MusicController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isPlaying READ isPlaying NOTIFY isPlayingChanged)
    Q_PROPERTY(QString currentTrackTitle READ currentTrackTitle NOTIFY currentTrackChanged)
    Q_PROPERTY(QString currentArtist READ currentArtist NOTIFY currentTrackChanged)
    Q_PROPERTY(int currentTrackIndex READ currentTrackIndex NOTIFY currentTrackChanged)
    Q_PROPERTY(int trackCount READ trackCount NOTIFY playlistChanged)
    Q_PROPERTY(qint64 duration READ duration NOTIFY durationChanged)
    Q_PROPERTY(qint64 position READ position NOTIFY positionChanged)
    Q_PROPERTY(int volume READ volume NOTIFY volumeChanged)

private:
    QMediaPlayer *m_player;
    QAudioOutput *m_audioOutput;
    QStringList m_playlist;
    QStringList m_trackTitles;
    QStringList m_trackArtists;
    int m_currentIndex;
    bool m_isPlaying;
    int m_volume;

    void loadPlaylist();
    void updateTrackInfo();

public:
    explicit MusicController(QObject *parent = nullptr);
    ~MusicController();

    bool isPlaying() const { return m_isPlaying; }
    QString currentTrackTitle() const;
    QString currentArtist() const;
    int currentTrackIndex() const { return m_currentIndex; }
    int trackCount() const { return m_playlist.count(); }
    qint64 duration() const;
    qint64 position() const;
    int volume() const { return m_volume; }

    Q_INVOKABLE void playPause();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void seek(qint64 position);
    Q_INVOKABLE void increment_volume();
    Q_INVOKABLE void decrement_volume();
    Q_INVOKABLE void playTrackAt(int index);

signals:
    void isPlayingChanged();
    void currentTrackChanged();
    void playlistChanged();
    void durationChanged();
    void positionChanged();
    void volumeChanged();

private slots:
    void onPlaybackStateChanged(QMediaPlayer::PlaybackState state);
    void onDurationChanged(qint64 duration);
    void onPositionChanged(qint64 position);
    void onMediaStatusChanged(QMediaPlayer::MediaStatus status);
};

#endif // MUSICCONTROLLER_H
