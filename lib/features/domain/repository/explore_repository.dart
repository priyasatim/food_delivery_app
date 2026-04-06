

import '../../data/model/explore_model.dart';

class ExploreRepository {
  Future<List<Explore>> fetchExplore() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Explore(title: "Offers", image: "assets/images/price_tag.png"),
      Explore(title: "Food on train", image: "assets/images/train.jpg"),
      Explore(title: "Crowd favourites", image: "assets/images/crowd_fav.jpg"),
      Explore(title: "Plan a party", image: "assets/images/party_food.png"),
      Explore(title: "Gift cards", image: "assets/images/gift_cards.png"),
    ];
  }
}