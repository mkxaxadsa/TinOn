import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/data/models/news_model/news_model.dart';

import 'models/travel_model/travel_model.dart';

class DataManager {
  static const _prefsKey = 'travelList';

  static List<TravelModel> travelModelsList = [];

  static Future<List<TravelModel>> loadTravelList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      travelModelsList =
          jsonList.map((travel) => TravelModel.fromJson(travel)).toList();
      return travelModelsList;
    }
    return [];
  }

  static Future<void> saveTravelList(List<TravelModel> travelList) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
    travelList.map((travel) => travel.toJson()).toList();
    prefs.setString(_prefsKey, json.encode(jsonList));
  }

  static Future<void> addTravelToList(TravelModel travel) async {
    final travelList = await loadTravelList();
    travelList.add(travel);
    await saveTravelList(travelList);
  }

  static Future<void> removeTravelFromList(TravelModel travelModel) async {
    final travelList = await loadTravelList();

    travelList.removeWhere((travel) =>
    travel.transport == travelModel.transport &&
        travel.countryName == travelModel.countryName);
    travelModelsList.remove(travelModel);
    await saveTravelList(travelList);
  }

  static List<TravelModel> getNearestTravels() {
    final now = DateTime.now();
    travelModelsList.sort((a, b) =>
        (a.startDate.difference(now))
            .abs()
            .compareTo((b.startDate.difference(now)).abs()));
    return travelModelsList.take(3).toList();
  }

  static Future<void> updateTravelInList(TravelModel newTravel,
      TravelModel oldTravel) async {
    final travelList = await loadTravelList();

    // Найдем индекс элемента, который мы хотим обновить
    final index = travelList.indexWhere((travel) =>
    travel.transport == oldTravel.transport &&
        travel.countryName == oldTravel.countryName);

    if (index != -1) {
      // Обновим элемент в списке
      travelList[index] = newTravel;

      // Сохраним обновленный список
      await saveTravelList(travelList);
    }
  }

  static List<NewsModel> getAllNews() {
    List<NewsModel> news = [
      NewsModel(
        imgUrl:
        'https://www.travelandleisure.com/thmb/epDdu1QH-0te_CBx48-pfhYzbbo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/TAL-seine-river-paris-SWIMSEINE0424-7d9f195de72f4daf8309f50ebdf1b450.jpg',
        title:
        'Olympic Organizers Concerned Over Swimming in the Seine After Pollution Report',
        body:
        'A European non-profit organization is warning the famous Seine may be too polluted to host Olympic swimming events, throwing an iconic part of the games into question. The Surfrider Foundation Europe tested the Paris river over the past six months and found concerning levels of bacteria in the sections where the triathlon, marathon swimming, and paratriathlon events will be held, according to the organization. In fact, out of the group’s bimonthly tests, only one sample was deemed “even satisfactory.” “It is therefore clear that the athletes who will be taking part in the Olympic and Paralympic events planned for the Seine will be swimming in polluted water and taking significant risks to their health,” the Surfrider Foundation Europe wrote in a statement. Following the group’s results, the president of the Paris Organizing Committee admitted to NBC News triathlon swimming could be postponed or even canceled if pollution levels remain too high. Paris 2024 President Tony Estanguet told the network he was “confident that it will be possible to use the Seine,” but added there could be “a final decision where we could not swim — it’s part of the rules of the International Federation. It’s what we want to avoid, of course.” The decision to open the Seine to the Olympic Games (and later to regular bathers) was considered to be monumental, allowing swimming in the famous river for the first time in more than 100 years. Following the games, Paris plans to open three official bathing sites to both visitors and residents in 2025. Since the announcement last year, Paris has been working to improve the water quality, including by installing a pair of disinfection units. Estanguet recently said organizers “are working hard on it. You know it’s one of the bigger challenges,” according to NBC News. “When we decided to have this competition in the Seine we knew it will be a big challenge,” he added. “But with the authorities there is a big program of investment and, when we talk about legacy, this project is fantastic.”',
      ),
      NewsModel(
        imgUrl: 'https://www.travelandleisure.com/thmb/McSnSITdDi_Tx88JxIe9w91GG0U=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/TAL-postcard-crossection-staten-island-ferry-venue-PETECOLINFERRY0424-2b1bcc4986eb45ad92a05533d9d1ef07.jpg',
        title: 'Pete Davidson and Colin Jost’s Staten Island Ferry Could Become a Roving Hotel in Destinations from New York to Miami — With 24 Rooms',
        body: 'When news first broke that Saturday Night Live comedians Pete Davidson and Colin Jost bought a retired 277-foot long Staten Island ferry boat in January 2022, reactions began with curious intrigue but quickly nosedived to comedy punchlines, even providing constant fodder on the sketch comedy show itself. But it turns out all those laughs may have covered up the fact that their investment in a massive \$280,000 non-working vessel is actually well on its way to become one of the most unconventional entertainment venues out there, complete with 24 hotel rooms, Curbed reported. “The goal is to keep the character and aesthetic from the original ferry and incorporate it with the comforts that are needed,” architect and developer Ron Castellano who runs Studio Castellano, and is also one of initial investors, told Travel + Leisure in a call this week. “It’s not trying to use the most expensive materials or the most intricate craftsmanship, but it’s certainly something that will be unique.” While initial reports said the floating landmark would focus purely on entertainment, as the schematic design phase began, the fifth floor veered into overnight accommodations. “We already have plenty of bars and restaurants in the venue, and when we were looking at that space with the balconies, it just lent itself to hotel rooms,” he said. Pete Davidson and anchor Colin Jost during Weekend Update on SNL WILL HEATH/NBC/NBCU PHOTO BANK VIA GETTY IMAGES Under the current designs, the two pilot houses on each end will transform into two-story suites, which are “more deluxe,” Castellano explained. The remaining rooms would be rather uniform, each getting the coveted New York City amenity of a sundeck. “That ferry for that class had an outdoor seating area on both sides, so that will get divided up with each of the rooms,” he said, noting that everything is still “preliminary.” Another innovative aspect of the Staten Island Ferry hotel is that the location may not be static. “It was built in Texas and has just been tugged wherever it needs to go,” Castellano said. “I think it would be interesting for the venue to travel to different cities at different times.” With the vast amount of outdoor roof space, the thought is that the renewed ferry could stay open year-round in warmer venues like Miami in the winter and then be tugged over to New York in the summer, perhaps even adding other eastern seaboard stops. “Right now, that’s on the table,” he explained. “It just seems like a great idea.” The challenge will be to find docking locations that can fit the massive length of the structure. “It’s not easy to find a place for it, but we’re looking at all the options.” With both Davidson, who left the late night comedy show in 2022, and Jost, who is now the longest-running “Weekend Update” cohost, being native Staten Islanders, there’s an inherent dedication to preserving the legacy of the orange ferry. In fact, Jost even used the southern borough’s icon as part of his public wedding announcement to Scarlett Johannson via Meals on Wheels America’s Instagram post.',
      ),
      NewsModel(
        imgUrl: 'https://www.travelandleisure.com/thmb/GeghDlRI-YvkV_ySPYWKQFt7QDQ=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/TAL-header-msc-euribia-MSCEURIBIA0623-d0ff233c766948bb836a58e2990d8cc1.jpg',
        title: 'MSC Cruises\' Latest Sale Has Voyages Starting at \$179 — When to Book',
        body: 'MSC Cruises is offering monumental savings on sailings to warm weather destinations starting at less than \$200 per person. The sale, which was extended and must be booked by April 18, offers cruises starting at just \$179 per person, according to MSC. The sale rate is based on double occupancy and does not include the taxes, fees, or port expenses. Travelers who take advantage of this deeply-discounted rate can sail on three and four night journeys from Miami for just \$179, or from Orlando starting at just \$189, MSC shared with Travel + Leisure. “It’s a great opportunity, whether you’re curious about cruising for the first time or you’re an avid cruiser looking to book your next sailing,” Koreen McNutt, the senior vice president and commercial sales officer for MSC Cruises USA, told T+L. “These quick getaways let guests discover everything we have to offer from world-class onboard entertainment and outstanding family programming to a variety of delicious dining venues and wonderful amenities. Plus, these short cruises all visit our private island in The Bahamas, Ocean Cay MSC Marine Reserve, with beautiful white-sand beaches and pristine water brimming with vibrant marine life.” The sale also includes MSC’s cruises from Galveston, which the company plans to introduce as its newest homeport in the United States in 2025. The cruise line expects to sail 7-night trips to Mexico and Central America on the MSC Seascape out of Galveston, which start at just \$459 per person during the sale. In addition, MSC is offering savings on its newest ship, the MSC World America, which the company plans to launch next year complete with a thrilling over-water swing ride, 13 different restaurants, an 11-deck-high dry slide, and more. Cruises on this ship start at just \$649 per person as part of the sale. “Cruising offers an unbeatable value proposition for vacations and we’re offering more itinerary options from a larger selection of embarkation ports than ever before, which makes it even easier for more people to discover what MSC Cruises is all about,” McNutt added. Beyond the cruise fare, MSC is offering the option for travelers to add a drink package and Wi-FI to their booking starting at just \$329.',
      ),
      NewsModel(
        imgUrl: 'https://www.travelandleisure.com/thmb/chbvqOCw6mLA1No5kCEC5cla8sA=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/TAL-summer-prices-HOP0423-2d3af13a9ee74725879e470974fc28f2.jpg',
        title: 'Here\'s When Summer Flight Prices Will Peak, According to Hopper',
        body: 'Summer travel is about to heat up, and flight prices may be downright scorching this season. Flight prices for this summer will peak around \$315 roundtrip for domestic getaways with fares starting to rise in May, according to predictions from booking site Hopper that was shared with Travel + Leisure. Peak prices will come at the end of May and early June. While these prices may be equal to or even surpass 2023 levels, they are still lower than pre-pandemic in 2019, Hayley Berg, Hopper’s lead economist, told T+L. “Slightly lower domestic airfares come as seat capacity has fully surpassed pre-pandemic levels and demand for summer travel remains strong among American consumers,” Berg said. “Airlines have achieved higher capacities by adding larger planes on routes rather than adding more flights as they remain constrained on physical supply of new aircrafts." When it comes to international trips, airfare prices remain higher than pre-pandemic levels to most regions of the world, but not nearly as high as last summer when airfare to Europe and Asia soared to a five-year high. An exception to that is Canada, which is seeing a 7 percent increase in prices compared to last summer and continues to see a 32 percent increase in prices compared to 2019. Travelers heading to Europe, however, can score flights at \$882 — much less than the average \$1,167 last summer. Beyond high prices, Berg said travelers should prepare for increased travel disruption rates, especially in June, July and August. As a result, Berg said Hopper is increasingly seeing travelers add rebooking services to their trips in case of cancellations or delays. When it comes to hotels, prices are currently averaging \$206 per night, which Hopper said is in line with costs this time last year. But while major U.S. cities will always remain popular, Hopper said domestic travelers are searching for “smaller, more off the beaten track cities and towns” this summer, like Cape Cod, Massachusetts, Cody, Wyoming, and Bar Harbor, Maine. Internationally, Osaka, Japan, is the top trending summer destination, followed by trips to Seoul, South Korea, and Nice, France.',
      ),
      NewsModel(
        imgUrl: 'https://www.travelandleisure.com/thmb/AeZ66UNEh3-edEVjPbeMTMkv9Nk=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/TAL-rio-de-janeiro-brazil-BRAZILVISA0424-7703a19b3761470fabd7eb174ddd5ce3.jpg',
        title: 'U.S. Travelers Won’t Need a Visa to Visit Brazil Just Yet — What to Know',
        body: 'Brazil has postponed its travel visa requirements for American visitors until 2025 just as it was set to go into effect. The new visa requirements for tourists from the United States, which has been postponed several times and was most recently set to go into effect on April 10 of this year, will now go into effect on April 10, 2025, according to the U.S. Embassy & Consulates in Brazil. A visa will also be required for tourists from Australia and Canada, Visit Rio shared with Travel + Leisure. "We applaud the government\'s decision… to delay the visa,\" Joao H. Rodrigues, the U.S. representative for Visit Rio, said in a statement shared with T+L. \"In the first two months of 2024, the arrival of Americans in Brazil was 11% higher than in the same period of the previous year. Without the visa requirement, we expect to maintain the growth in the arrival of foreign tourists from these international markets visiting Brazil and [especially] Rio de Janeiro.\" When it does take effect, American travelers will need to obtain an electronic visa to enter the country. The e-visa will cost \$80.90 per person and will be valid for 10 years, according to the U.S. Embassy & Consulates in Brazil. The decision to bring back these visa requirements comes about five years after the country eliminated visa rules for U.S. travelers exploring for up to 90 days. While Brazil is bringing back visa rules for American travelers next year, several countries are dropping them or making it easier for U.S. tourists to visit. Turkey, for example, dropped visa requirements earlier this year for travelers visiting from both America and Canada. And China made it easier for Americans to visit by eliminating the requirement for U.S. travelers to submit proof of a round-trip air ticket, proof of a hotel reservation, proof of their itinerary, or an invitation letter to apply for a tourist visa. There are also several other countries where American travelers are not required to obtain a visa before going, including many European, Caribbean, Central American, and South American countries.',
      ),
      NewsModel(
        imgUrl: 'https://www.travelandleisure.com/thmb/k2dUud8_rjNgFpb-okBh3FzGHJk=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/TAL-delta-a330-interior-DLTASKYWIFI1122-c0d5a805fd484092ae85f5c4b5be585b.jpg',
        title: 'Delta Is Changing How It Classifies Boarding Groups',
        body: 'Delta Air Lines is simplifying the way it boards its aircraft, becoming the latest airline to make changes to the boarding process. Starting May 1, Delta will change how it classifies the different boarding zones, switching to a number-based system, the airline confirmed to Travel + Leisure. The actual boarding order will remain the same with the new system. The renamed boarding zones are being introduced “to provide customers with more clarity about [the] boarding sequence,” the airline said in a statement. “Customer boarding passes — including printed boarding passes and those accessed via the Fly Delta app — will reflect the new zone numbers, along with updated sequencing on airport screens and in gate announcements,” the airline added. The airline will then welcome customers in the following order: Zone 1: Delta One and first class customers Zone 2: Diamond Medallion members and Delta Premium Select Cabin passengers Early access: Customers traveling with car seats and strollers Zone 3: Delta Comfort+ passengers Zone 4: Sky Priority customers Zone 5: Main Cabin 1 passengers Zone 6: Main Cabin 2 passengers Zone 7: Main Cabin 3 passengers Zone 8: Basic economy passengers The airline told T+L the new numbered zones will make the boarding process more self-intuitive and align more closely with Delta’s international partners. However, Delta will continue to offer pre-boarding for customers who need extra time or assistance as well as active-duty military members and Delta 360 members. At the airport, travelers boarding in zones one to four will use the Sky Priority lane, while travelers boarding in zones five to eight will use the airline’s general boarding lane. Delta said the boarding lane signs will be updated to show the new boarding zone numbers. Delta isn’t alone in changing how it boards its aircraft. Late last year, United Airlines updated its boarding procedure to allow travelers in window and middle seats to board earlier in an effort to speed up the process.',
      ),
      NewsModel(
        imgUrl: 'https://www.travelandleisure.com/thmb/xI3G_qrb1e84gY2Fha2lhYHpSnY=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/TAL-british-airways-boeing-inflight-BASTATUSMATCH0424-b5b734b789504c528201d40499f76c63.jpg',
        title: 'British Airways Is Offering Status Matching With Delta, United, and More — When to Apply',
        body: 'British Airways is making it easier for passengers in the United States to fly in style with a new limited-time status match offer. The airline is welcoming members of eight different airline loyalty programs to status match for free, British Airways shared with Travel + Leisure. Eligible customers who apply by May 7 will receive either British Airways’ Silver or Gold status for six months with the ability to extend that to a full year with the purchase of two qualifying flights. The eligible airlines include Delta Air Lines, Air Canada, Lufthansa, United Airlines, Air France/KLM, Scandinavian Airlines, and Virgin Atlantic. Travelers who hold gold status with Delta, for example, can receive British Airways Silver status, while Delta Platinum members can receive British Airways Gold status. The same goes for United Airlines Premier Gold members, who are eligible to receive British Airways Silver status, or United’s Premier Platinum and Premier 1k members, who are eligible to receive British Airways Gold status. American Airlines customers already receive benefits when flying with British Airways since the airlines are both members of the Oneworld Alliance. Beyond the six month period, travelers can extend the status match when they book two qualifying flights or one roundtrip flight. To qualify, the flight must be a business or first class ticket originating in the U.S., Canada, or Mexico, marketed by British Airways, and operated by British Airways, American Airlines, Aer Lingus, Iberia, or Finnair. To request status matching, customers must apply online and upload proof of their existing airline status. Customers will then be notified if they are eligible via email within about five business days. Airlines all around the world offer status matching as a perk, allowing travelers to test a new loyalty program before fully committing to that airline. Beyond status matching, British Airways is offering a spring sale with big savings on international trips to London, Madrid, India, and beyond. To take advantage, the sale must be booked by 11:59 p.m. ET on April 23.',
      ),
      NewsModel(
        imgUrl: 'https://www.travelandleisure.com/thmb/u-x_WdlWfoYoT7WENTLdWFVsmFQ=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/TAL-uber-nyc-UBERSAFEFE0424-4483d00ec77a4cd19be199e43c11fba4.jpg',
        title: 'Uber Just Updated Its Safety Features — What to Know',
        body: 'Uber is offering more peace of mind to riders with an update to its safety features. Now, riders can automatically opt into the app\'s safety features for specific times — such as pin verification, the in-app emergency button, and audio recording — Uber shared with Travel + Leisure. Previously, riders could manually turn this feature on or off but not set it for specific times. Going forward, travelers will be able to set a specific day and time in the app to turn on pin verification, which will automatically be required to start a trip during those chosen times. Travelers will also be able to schedule the “Share My Trip” feature, automatically sending their location when they’re picked up or dropped off within 50 meters of a bar or restaurant. Riders also have access to an in-app emergency button if they feel in danger. In addition, the company said riders now have the ability to turn on the audio recording feature for every trip “so in the rare instance that something goes wrong, the encrypted recording will be shared with Uber.” “No matter the journey, we want riders to have peace of mind when using the Uber app which is why we are making it easier than ever to leverage our in-app safety features, especially at night,” Emilie Boman, the director of safety public policy at Uber, told T+L. “We are all about giving riders more choice and control over their safety features, and safety preferences does just that.” To set up these safety features, riders should scroll to the safety preferences section in their in-app settings. Travelers can also update their safety preferences during a ride by tapping on the blue shield icon. Beyond safety updates, Uber has introduced new features over the years to make booking a ride easier. Last year, for example, the rideshare company rolled out step-by-step directions and timed walking estimates to help travelers find airport rides and expanded its Uber Reserve option.',
      ),
    ];

    return news;
  }
}
