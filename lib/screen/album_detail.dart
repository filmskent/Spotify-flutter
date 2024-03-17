import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_flutter/model/albumModel.dart';
import 'package:spotify_flutter/repository/album_repository.dart';

class AlbumDetailPage extends StatefulWidget {
  AlbumDetailPage({Key? key, required this.id}) : super(key: key);
  final String? id;

  @override
  _AlbumDetailPageState createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  late Future<AlbumDetail> _albumDetailFuture;

  void initState() {
    super.initState();
    _albumDetailFuture = AlbumRepository().getAlbum(widget.id!);
  }

  Widget buildProductImage(AlbumDetail albumDetail) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Image.network(
        albumDetail.url!,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget buildProductDetail(AlbumDetail albumDetail) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      albumDetail.name!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      albumDetail.artist!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "genre: ${albumDetail.genre!}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.favorite,
                    size: 50,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: FutureBuilder<AlbumDetail>(
            future: _albumDetailFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final albumDetail = snapshot.data!;
                return Column(
                  children: [
                    Column(
                      children: [
                        buildProductImage(albumDetail),
                        buildProductDetail(albumDetail),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: albumDetail.songList?.length,
                        itemBuilder: (context, index) {
                          final song = albumDetail.songList?[index];
                          int seconds = (song!.duration ?? 0) ~/ 1000;
                          int minutes = seconds ~/ 60;
                          int remainingSeconds = seconds % 60;
                          final duration =
                              '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';

                          return ListTile(
                            title: Text(song.name ?? ''),
                            subtitle: Text("${song.artist ?? ''} - $duration"),
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
