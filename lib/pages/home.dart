import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time_app/classes/get_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  List countryList = AllCountries.allCountries;

  getDataLoading() async {
    AllCountries oneCountry =
        AllCountries(countryName: '', flag: '02.gif', link: '');

    await oneCountry.getData();

    // ignore: use_build_context_synchronously
    setState(() {
      data = {
        'time': oneCountry.timeNow,
        'zone': oneCountry.timeZone,
        'isDayTime': oneCountry.isDayTime,
        'flag': oneCountry.flag
      };
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty
          ? const Center(
              child: SpinKitWaveSpinner(
                color: Color.fromARGB(255, 59, 159, 241),
                waveColor: Color.fromARGB(133, 37, 204, 101),
                size: 180,
                trackColor: Color.fromARGB(133, 37, 204, 101),
                curve: Curves.easeIn,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(data['isDayTime']
                        ? 'assets/day.png'
                        : 'assets/night.png'),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        dynamic result = await showModalBottomSheet(
                          backgroundColor: const Color(0xff596275),
                          useSafeArea: true,
                          isScrollControlled: true,
                          showDragHandle: true,
                          elevation: 0,
                          context: context,
                          builder: (BuildContext context) {
                            return ListView.builder(
                              padding: const EdgeInsets.all(2),
                              itemCount: countryList.length,
                              itemBuilder: (BuildContext context,dynamic index) {
                                return Card(
                                  color: const Color(0xffa4b0be),
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: ListTile(
                                    onTap: () async {
                                      AllCountries clickedCountry =
                                          countryList[index];

                                      await clickedCountry.getData();

                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context, {
                                        'time': clickedCountry.timeNow,
                                        'zone': clickedCountry.timeZone,
                                        'isDayTime': clickedCountry.isDayTime,
                                        'flag': clickedCountry.flag,
                                      });
                                    },
                                    title: Text(
                                      countryList[index].countryName,
                                      style: const TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/${countryList[index].flag}'),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                        print(result);
                        setState(() {
                          if (result == null) {
                            data = {
                              'time': 'PLEASE',
                              'zone': 'Choose A Location',
                              'isDayTime': false,
                              'flag': '02.gif',
                            };
                          } else {
                            data = result;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.edit_location,
                        color: Color.fromARGB(255, 255, 129, 129),
                        size: 28.0,
                      ),
                      label: const Text(
                        "Edit Location",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(150, 90, 104, 223)),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(22)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                      ),
                    ),
                    // SizedBox(
                    //   height: 350,
                    // ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 25,
                      ),
                      width: double.infinity,
                      color: const Color.fromARGB(85, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/${data['flag']}'),
                            radius: data['flag'] == '02.gif' ? 50 : 63,
                          ),
                          Column(
                            children: [
                              Text(
                                data['time'],
                                style: const TextStyle(
                                    fontSize: 55,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                data['zone'],
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
