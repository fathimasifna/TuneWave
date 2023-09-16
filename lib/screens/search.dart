import 'package:flutter/material.dart';
import 'package:music_player/database/fuctions/all_music_db_functions.dart';
import 'package:music_player/database/model/data_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/screens/song_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SongsModel> musicList = [];
  List<SongsModel> filteredMusicList = [];
  final AudioPlayer audioPlayer = AudioPlayer();
  SongsModel? currentlyPlayingSong;

  @override
  void initState() {
    super.initState();
    fetchMusicList();
  }

  Future<void> fetchMusicList() async {
    final musicBox = await AllMusicFunctions.instance.createMusicBox();
    setState(() {
      musicList = musicBox.values.toList();
      filteredMusicList = musicList;
    });
  }

  // ignore: unused_element

  Future<void> _playSong(SongsModel song) async {
    try {
      await audioPlayer.stop();
      await audioPlayer.setUrl(song.audioUri!);
      await audioPlayer.play();
      setState(() {
        currentlyPlayingSong = song;
      });
    } catch (e) {
      // ignore: avoid_print

      print('Error on playing Songs: $e');
    }
  }

  void _filterMusicList(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredMusicList = musicList;
      });
    } else {
      setState(() {
        filteredMusicList = musicList
            .where((song) =>
                song.title!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Search",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 40, 32, 51),
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 40, 32, 51),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (query) {
                  _filterMusicList(query);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15,
                  ),
                  hintText: "Search",
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(),
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredMusicList.length,
                itemBuilder: (context, index) {
                  final song = filteredMusicList[index];
                  return ListTile(
                    title: Text(
                      song.title!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    subtitle: Text(
                      song.subtitle!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/home.jpg'),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongScreen(
                            songModel: song,
                            musicList: musicList,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
