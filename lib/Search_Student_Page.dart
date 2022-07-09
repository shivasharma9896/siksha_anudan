import 'dart:async';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siksha_anudan/Profile_card.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:endless/endless.dart';
import 'ComboBoxSearchStudentFilter.dart';
import 'model/Student_model.dart';


final List<SelectedListItem> _listOfCities = [
  SelectedListItem(false, "Delhi"),
  SelectedListItem(false, "Patna"),
  SelectedListItem(false, "Gurgaon"),
  SelectedListItem(false, "Bangalore"),
  SelectedListItem(false, "Kolkata"),
  SelectedListItem(false, "Bhopal"),
  SelectedListItem(false, "Ahmedabad"),
  SelectedListItem(false, "Chandigarh"),
  SelectedListItem(false, "Indore"),
  SelectedListItem(false, "Chennai"),
  SelectedListItem(false, "Hyderabad"),
  SelectedListItem(false, "Kota"),
];
final List<SelectedListItem> _incomelist = [
  SelectedListItem(false, "Below 1,00,000"),
  SelectedListItem(false, "1,00,000 - 3,00,000"),
  SelectedListItem(false, "4,00,000 - 7,00,000"),
  SelectedListItem(false, "7,00,000 - 10,00,000"),
];
final List<SelectedListItem> _amountOfAid = [
  SelectedListItem(false, "Below 1,00,000"),
  SelectedListItem(false, "1,00,000 - 3,00,000"),
  SelectedListItem(false, "4,00,000 - 7,00,000"),
  SelectedListItem(false, "7,00,000 - 10,00,000"),
];

class ExampleItem {
  final String title;

  ExampleItem({
    required this.title,
  });
}

class ExampleItemPager {
  int pageIndex = 0;
  final int pageSize;

  ExampleItemPager({
    this.pageSize = 20,
  });

  List<ExampleItem> nextBatch() {
    List<ExampleItem> batch = [];

    for (int i = 0; i < pageSize; i++) {
      batch.add(ExampleItem(title: 'Item ${pageIndex * pageSize + i}'));
    }

    pageIndex += 1;

    return batch;
  }
}

class SearchStudent_Page extends StatefulWidget {

  const SearchStudent_Page({Key? key}) : super(key: key);

  @override
  State<SearchStudent_Page> createState() => _SearchStudent_Page();
}

class _SearchStudent_Page extends State<SearchStudent_Page> {
  final _auth=FirebaseAuth.instance;
  late User loggedUser;
  List studentProfileList=[];
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchStudentList();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => (context));
  }
  Future<List> fetchStudentList()async{
    dynamic resultant=await StudentModel().getStudentList();
    if(resultant==null){
      print("unable to retrieve");
    }
    else{
      setState((){
        studentProfileList=resultant;
      });
    }
    return studentProfileList;
  }

  void getCurrentUser()async{
    try{
      final user=_auth.currentUser!;
      loggedUser=user;
      print("user email");
      print(loggedUser.email);
    }
    catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body:  Container(
          child: ListView.builder(itemCount: studentProfileList.length,itemBuilder: (context,index){
            return Search_Profile_Card(studentProfileList: studentProfileList[index],);
          }))
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ExampleItemPager pager = ExampleItemPager();
    return
      Container(
        padding: const EdgeInsets.only(top: 30),
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 350,
          child: PaginatedSearchBar<ExampleItem>(
            maxHeight: 300,
            hintText: 'Search Student',
            paginationDelegate: EndlessPaginationDelegate(
              pageSize: 20,
              maxPages: 3,
            ),
            onSearch: ({
              required pageIndex,
              required pageSize,
              required searchQuery,
            }) async {
              return Future.delayed(const Duration(milliseconds: 1300), () {
                if (searchQuery == "empty") {
                  return [];
                }

                if (pageIndex == 0) {
                  pager = ExampleItemPager();
                }

                return pager.nextBatch();
              });
            },
            itemBuilder: (
                context, {
                  required item,
                  required index,
                }) {
              return Text(item.title);
            },
          ),
        ),
      );
  }
}

