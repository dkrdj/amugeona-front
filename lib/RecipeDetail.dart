import 'package:flutter/material.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({super.key});

  @override
  State<RecipeDetail> createState() => _RecipeDetail();
}

class _RecipeDetail extends State<RecipeDetail> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      final List<RecipeIngredient> ingreList = [];
      final List<RecipeContent> contentList = [];
      final List<RecipeImage> imageList = [];
      for (int i = 0; i < 10; i++) {
        ingreList.add(RecipeIngredient('재료${i}', i + 1));
        contentList.add(RecipeContent(
            '${i + 1}. 조리방법${i + 1}번입니다.조리방법${i + 1}번입니다.조리방법${i + 1}번입니다.조리방법${i + 1}번입니다.',
            i + 1));
        imageList.add(RecipeImage('assets/images/logo.png', i + 1));
      }
      imageList.removeAt(6); // 7번째는 이미지 없음
      imageList.removeAt(3); // 4번째는 이미지 없음

      Recipe recipe = Recipe("김치찌개 지리게 끓이는 법", 'assets/images/logo.png',
          ingreList, contentList, imageList);

      return ListView(
        padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
        children: [
          Text(
            recipe.title,
            style: TextStyle(
              fontSize: width / 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height / 30, bottom: height / 30),
            child: Image(
              image: AssetImage(recipe.thumbnail),
              height: height / 4.8,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: height / 80,
            ),
            child: Text(
              '재료',
              style: TextStyle(
                fontSize: width / 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          for (int i = 0; i < recipe.recipeIngredients.length; i += 2)
            Row(
              children: [
                for (int j = i;
                    j <= i + 1 && j < recipe.recipeIngredients.length;
                    j++)
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        width / 48, height / 60, width / 48, 0),
                    width: width / 2 - width / 15 - width / 24,
                    height: height / 35,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    child: Text(
                      recipe.recipeIngredients[j].name,
                      style: TextStyle(
                        fontSize: width / 32,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                  ),
              ],
            ),
          Container(
            width: width - width / 15 * 2,
            margin: EdgeInsets.only(top: height / 40, bottom: height / 40),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 3.5,
                  color: Colors.black45,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: height / 80,
            ),
            child: Text(
              '만드는 법',
              style: TextStyle(
                fontSize: width / 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          for (int i = 0, j = 0; i < recipe.recipeContents.length; i++)
            Column(
              children: [
                if (recipe.recipeImage[j].idx == i + 1)
                  Container(
                    height: height / 4.8,
                    margin: EdgeInsets.fromLTRB(0, height / 80, 0, height / 80),
                    child: Image.asset(recipe.recipeImage[j++].url),
                  ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, height / 80, 0, height / 80),
                  child: Text(
                    recipe.recipeContents[i].content,
                    style: TextStyle(
                      fontSize: width / 32,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            )
        ],
      );
    });
  }
}

class Recipe {
  String title;
  String thumbnail;
  List<RecipeIngredient> recipeIngredients;
  List<RecipeContent> recipeContents;
  List<RecipeImage> recipeImage;

  Recipe(this.title, this.thumbnail, this.recipeIngredients,
      this.recipeContents, this.recipeImage);
}

class RecipeImage {
  String url;
  int idx;

  RecipeImage(this.url, this.idx);
}

class RecipeContent {
  String content;
  int idx;

  RecipeContent(this.content, this.idx);
}

class RecipeIngredient {
  String name;
  int idx;

  RecipeIngredient(this.name, this.idx);
}
