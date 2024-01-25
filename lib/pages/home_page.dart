import 'package:flutter/material.dart';
import 'package:music_player/components/my_drawer.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get the play list provider
  late final dynamic playlistProvider;

  @override
  void initState() {
    // TODO: implement initState

    //get play list provider
    playlistProvider = Provider.of<PlayListProvider>(context, listen: false);
    super.initState();
  }

  //go to song function
  void goToSong(int songIndex) {
    //update current song index
    playlistProvider.currentSongIndex = songIndex;

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SongPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('P L A Y L I S T'),
      ),
      drawer: MyDrawer(),
      body: Consumer<PlayListProvider>(builder: (context, value, child) {
        //get play list
        final List<Song> playList = value.playList;
        return ListView.builder(
            itemCount: playList.length,
            itemBuilder: (context, index) {
              final Song song = playList[index];
              //get individual song

              //return list tile
              return Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        song.albumImagePath,
                        width: 80,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(song.songName),
                    subtitle: Text(song.artistName),
                    trailing: const Icon(Icons.more_vert),
                    onTap: () => goToSong(index),
                  ),
                ),
              );
            });
      }),
    );
  }
}
