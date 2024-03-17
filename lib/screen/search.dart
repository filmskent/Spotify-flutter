import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:spotify_flutter/model/albumModel.dart';
import 'package:spotify_flutter/repository/album_repository.dart';
import 'package:spotify_flutter/screen/album_detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const int PAGE_SIZE = 20;
  String _searchQuery = '';

  Future<List<Album>> _getAlbums(int? pageIndex) async {
    try {
      if (_searchQuery.isEmpty) {
        return [];
      } else {
        return AlbumRepository()
            .searchAlbums(_searchQuery, pageIndex! * PAGE_SIZE, PAGE_SIZE);
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error searching data: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return [];
    }
  }

  void _onSearchTextChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: _onSearchTextChanged,
          decoration: const InputDecoration(
            hintText: 'Search Album...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          PagewiseSliverList<Album>(
            pageLoadController: PagewiseLoadController(
              pageFuture: _getAlbums,
              pageSize: PAGE_SIZE,
            ),
            itemBuilder: (context, Album album, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push<Widget>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlbumDetailPage(id: album.id),
                    ),
                  );
                },
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          image: album.url != null
                              ? DecorationImage(
                                  image: NetworkImage(album.url!),
                                  fit: BoxFit.fill,
                                )
                              : null,
                        ),
                      ),
                      title: Text(album.name!),
                      subtitle: Text(album.artist!),
                    ),
                    const Divider()
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

  // Container(
  //   padding: const EdgeInsets.symmetric(horizontal: 20),
  //   child: Column(
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.symmetric(vertical: 20),
  //         alignment: Alignment.topLeft,
  //         child: const Text(
  //           "For You",
  //           style: TextStyle(
  //             fontSize: 35,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //     CustomScrollView(
  //   slivers: <Widget>[
  //     const SliverAppBar(
  //       title: Text('This is a sliver app bar'),
  //       floating: true,
  //       snap: true,
  //     ),
  //     SliverPadding(
  //       padding: const EdgeInsets.all(8.0),
  //       sliver: PagewiseSliverGrid<Album>.count(
  //         pageSize: 20,
  //         crossAxisCount: 2,
  //         mainAxisSpacing: 8.0,
  //         crossAxisSpacing: 8.0,
  //         childAspectRatio: 0.555,
  //         itemBuilder: (context, Album album, index) {
  //           return Container(
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.grey[600]!),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Expanded(
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey[200],
  //                       image: album.url != null
  //                           ? DecorationImage(
  //                               image: NetworkImage(album.url!),
  //                               fit: BoxFit.fill,
  //                             )
  //                           : null,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8.0),
  //                 Expanded(
  //                   child: Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: 8.0),
  //                     child: SizedBox(
  //                       height: 30.0,
  //                       // width: 30.0,
  //                       child: Text(
  //                         album.name ?? '',
  //                         style: TextStyle(fontSize: 12.0),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8.0),
  //                 const Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: 8.0),
  //                   child: Text(
  //                     "2",
  //                     style: TextStyle(fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8.0)
  //               ],
  //             ),
  //           );
  //         },
  //         pageFuture: (pageIndex) => AlbumRepository().getAlbum(),
  //       ),
  //     )
  //   ],
  //   //     ),
  //   //   ],
  //   // ),
  // );

