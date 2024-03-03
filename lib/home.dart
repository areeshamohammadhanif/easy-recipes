
import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class Recipe {
  final String title;
  final String subtitle;
  final String imageUrl;
  final data;

  Recipe({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.data
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['name'],
      subtitle: json['cuisine'],
      imageUrl: json['image'],
      data: json
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));

    if (response.statusCode == 200) {
      List<dynamic> result = json.decode(response.body)['recipes'];
      List<Recipe> recipeList = [];

      for (var recipeJson in result) {
        recipeList.add(Recipe.fromJson(recipeJson));
      }

      setState(() {
        recipes = recipeList;
      });
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to the recipe world'),
      ),
      body:
       recipes != null
          ? ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(
          title: recipe.title,
          subtitle: recipe.subtitle,
          imageUrl: recipe.imageUrl,
          data:recipe.data
        ),
      ),
    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Image.network(
                              recipe.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recipe.title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  recipe.subtitle,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}


class RecipeDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final dynamic data;

  RecipeDetailScreen({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    List<String> ingredients = List<String>.from(data['ingredients']);
    List<String> instructions = List<String>.from(data['instructions']);
    int prepTimeMinutes = data['prepTimeMinutes'];
    int cookTimeMinutes = data['cookTimeMinutes'];
    int servings = data['servings'];
    String difficulty = data['difficulty'];
    String cuisine = data['cuisine'];
    double caloriesPerServing = data['caloriesPerServing'].toDouble();
    List<String> tags = List<String>.from(data['tags']);
    double rating = data['rating'];
    int reviewCount = data['reviewCount'];
    List<String> mealType = List<String>.from(data['mealType']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Ingredients:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ingredients
                        .map((ingredient) => Text('- $ingredient'))
                        .toList(),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Instructions:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: instructions
                        .asMap()
                        .entries
                        .map(
                          (entry) => Text(
                            '${entry.key + 1}. ${entry.value}',
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Prep Time: $prepTimeMinutes minutes',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Cook Time: $cookTimeMinutes minutes',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Servings: $servings',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Difficulty: $difficulty',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Cuisine: $cuisine',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Calories Per Serving: $caloriesPerServing',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Rating: $rating',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Review Count: $reviewCount',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Meal Type: ${mealType.join(", ")}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tags: ${tags.join(", ")}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
