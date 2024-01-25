import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(
        builder: (context, value, child) {

          final playlist = value.playList;
          final currentSong = playlist[value.currentSongIndex ?? 0];
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //back button
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back)),
                        //title
                        const Text('P L A Y L I S T'),
                        //menu button
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.menu))
                      ],
                    ),
                    NeuBox(
                        child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(currentSong.albumImagePath)),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(currentSong.songName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), Text(currentSong.artistName)],
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: isFavorite ? Colors.red : Colors.grey,
                                  ))
                            ],
                          ),
                        )
                      ],
                    )
                    ),
                    const SizedBox(height: 25,),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('0:00'),
                          Icon(Icons.shuffle),
                          Icon(Icons.repeat),
                          Text('0:00')
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: 
                        const RoundSliderThumbShape(enabledThumbRadius: 0)
                      ),
                      child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        activeColor: Colors.green,
                        value: value.currentDuration.inSeconds.toDouble(), onChanged: (double double) {
                      
                      },
                        onChangeEnd: (double double) {
                          //sliding has finished, go to that position in song duration
                          value.seek(Duration(seconds: double.toInt()));
                        },
                      ),
                    ), 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: const NeuBox(child: Icon(Icons.skip_previous)))),
                        const SizedBox(width: 25,),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child: NeuBox(child: value.isPlaying ? const Icon(Icons.pause): const Icon(Icons.play_arrow)))),
                        const SizedBox(width: 25,),
                        Expanded(child: GestureDetector(
                          onTap: value.playNextSong,
                          child: const NeuBox(child: Icon(Icons.skip_next)))),
                      ],
                    )
                  ],
                ),
              ),
            ));
        }
            );
  }
}
