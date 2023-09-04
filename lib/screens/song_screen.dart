import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/database/model/data_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongScreen extends StatefulWidget {
  SongScreen({Key? key, required this.songModel, required this.musicList})
      : super(key: key);

  SongsModel songModel;
  final List<SongsModel> musicList;

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  Duration position = const Duration();
  Duration duration = const Duration();
  bool _isPlaying = true;

  final AudioPlayer audioPlayer = AudioPlayer();
  Future<void> toggleFavorite(SongsModel song) async {
    setState(() {
      song.isFavorite = !song.isFavorite;
    });
    await Hive.box<SongsModel>('favourite_box').put(song.id, song);
  }

  Future<void> playSong(String? uri) async {
    final audioSource = AudioSource.uri(Uri.parse(uri!));
    try {
      await audioPlayer.setAudioSource(audioSource);
      audioPlayer.play();
    } catch (e) {
      // ignore: avoid_print
      print('Error on playing Songs: $e');
    }
  }
           
  void playNextSong() {
    final currentIndex = widget.musicList.indexOf(widget.songModel);
    final nextIndex = (currentIndex + 1) % widget.musicList.length;

    final nextSong = widget.musicList[nextIndex];
    setState(() {
      widget.songModel = nextSong;
    });
    playSong(nextSong.audioUri!);
  }

  void playPreviousSong() {
    final currentIndex = widget.musicList.indexOf(widget.songModel);
    final previousIndex =
        (currentIndex - 1 + widget.musicList.length) % widget.musicList.length;
    final previousSong = widget.musicList[previousIndex];
    setState(() {
      widget.songModel = previousSong;
    });
    playSong(previousSong.audioUri!);
  }

  @override
  void initState() {
    super.initState();
    final audioUri = widget.songModel.audioUri;
    if (audioUri != null) {
      playSong(audioUri);
    }

    audioPlayer.durationStream.listen((d) {
      setState(() {
        duration = d ?? const Duration();
      });
    });

    audioPlayer.positionStream.listen((p) {
      setState(() {
        position = p;
      });
    });

    audioPlayer.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        playNextSong();
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 40, 32, 51),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, right: 20, left: 28, bottom: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 35,
                      right: 40,
                      left: 45,
                      bottom: 10,
                    ),
                    child: QueryArtworkWidget(
                      id: widget.songModel.id!,
                      type: ArtworkType.AUDIO,
                      artworkWidth: 200,
                      artworkHeight: 200,
                      artworkFit: BoxFit.cover,
                      nullArtworkWidget: Image.asset(
                        'assets/images/home.jpg',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      toggleFavorite(widget.songModel);
                    },
                    icon: Icon( 
                      widget.songModel.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.songModel.isFavorite
                          ? Colors.red
                          : Colors.white60,
                      size: 35,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child:SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        widget.songModel.title ?? '',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 209, 207, 207),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ), 
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.songModel.subtitle ?? '',
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  right: 25,
                  left: 25,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        onPressed: () {
                          playPreviousSong();
                        },
                        icon: const Icon(
                          Icons.skip_previous_outlined,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (_isPlaying) {
                              audioPlayer.pause();
                            } else {
                              audioPlayer.play();
                            }
                            _isPlaying = !_isPlaying;
                          });
                        },
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.black,
                          size: 35,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        onPressed: () {
                          playNextSong();
                        },
                        icon: const Icon(
                          Icons.skip_next_outlined,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: duration.inMilliseconds.toDouble(),
                        value: position.inMilliseconds.toDouble(),
                        activeColor: const Color.fromARGB(255, 243, 240, 240),
                        inactiveColor: const Color.fromARGB(255, 201, 200, 200),
                        onChanged: (value) {
                          setState(() {
                            audioPlayer.seek(
                              Duration(milliseconds: value.toInt()),
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      position.toString().split(".")[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      duration.toString().split(".")[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ), 
        ),
      ),
    );
  }
}
