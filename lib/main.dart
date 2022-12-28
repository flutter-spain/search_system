import 'package:flutter/material.dart';
import 'package:search_system/model/movie_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static List<MovieModel> main_movie_list = [
      MovieModel("Te amo Marlon", 2022, "https://images.photowall.com/products/51078/movie-poster-jaws.jpg?h=699&q=85", 9.3),
      MovieModel("Que linda es Yury", 1992, "https://i.ebayimg.com/images/g/J1sAAOSwCeNijpzE/s-l500.jpg", 6.3),
      MovieModel("Marlito es un amor", 1980, "https://product-image.juniqe-production.juniqe.com/media/catalog/product/seo-cache/x800/171/230/171-230-101P/The-Shining-Retro-Movie-Poster-Vintage-Photography-Archive-Poster.jpg", 10.0),
  ];

  List<MovieModel> display_list = List.from(main_movie_list);

  void updateList(String value) {
    setState(() {
      display_list = main_movie_list
          .where((element) => element.movie_title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[600],
        title: const Text('Search Page'),
        elevation: 0.0,
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Busca tu pelicula favorita',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.lightBlue[900],
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20.0),

            TextField(
                onChanged: (value) => updateList(value),
                decoration: InputDecoration(
                hintText: 'Bucar peliculas...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            Expanded(
              child: display_list.length > 0
                  ? ListView.builder(
                      itemCount: display_list.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Image.network(display_list[index].movie_poster_url!),
                            title: Text(display_list[index].movie_title!),
                            subtitle: Text(display_list[index].movie_release_year.toString()),
                            trailing: Text(display_list[index].rating.toString()),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No hay peliculas'),
                    ),
            )
          ],
        ),
      )
      
    );
  }
}