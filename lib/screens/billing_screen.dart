import 'package:dribble_ui/core/theme/colors.dart';
import 'package:dribble_ui/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  String? dropdownValue;

  String? _selectedOpinion;

  double totalBillAmount = 0;

  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/display_picture.jpg',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Celeste',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bill amount',
                            style: TextStyleClass.splashScreenTextStyle
                                .copyWith(fontSize: 14, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              setState(() {
                                if (val.isEmpty) {
                                  totalBillAmount = 0.0;
                                } else {
                                  try {
                                    _selectedOpinion = null;
                                    totalBillAmount = double.parse(val);
                                  } catch (e) {
                                    totalBillAmount = 0.0;
                                  }
                                }
                              });
                            },
                            controller: amountController,
                            decoration: InputDecoration(
                              prefixText: '₹ ',
                              prefixStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold),
                              fillColor:
                                  const Color.fromARGB(255, 231, 239, 244)
                                      .withOpacity(0.7),
                              filled: true,
                              hintText: 'Enter Bill Amount',
                              hintStyle: GoogleFonts.poppins(fontSize: 12),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          totalBillAmount == 0
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Are you willing to add a tip amount?',
                                      style: TextStyleClass
                                          .splashScreenTextStyle
                                          .copyWith(
                                              fontSize: 14,
                                              color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: 'Yes',
                                          groupValue: _selectedOpinion,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedOpinion = value;
                                            });
                                          },
                                        ),
                                        const Text('Yes'),
                                        Radio<String>(
                                          value: 'No',
                                          groupValue: _selectedOpinion,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedOpinion = value;
                                              totalBillAmount = double.parse(
                                                  amountController.text);
                                              dropdownValue = null;
                                            });
                                          },
                                        ),
                                        const Text('No'),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        _selectedOpinion == 'Yes'
                                            ? Expanded(
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 50,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: DropdownButton<String>(
                                                    underline: const SizedBox(),
                                                    value: dropdownValue,
                                                    hint: Text(
                                                      'Tip',
                                                      style: TextStyleClass
                                                          .splashScreenTextStyle
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                    iconSize: 25,
                                                    elevation: 16,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        dropdownValue =
                                                            newValue!;

                                                        String addedValue =
                                                            newValue.substring(
                                                                0, 2);

                                                        setState(() {
                                                          totalBillAmount =
                                                              double.parse(
                                                                  amountController
                                                                      .text);
                                                          totalBillAmount =
                                                              totalBillAmount +
                                                                  totalBillAmount *
                                                                      (double.parse(
                                                                              addedValue) /
                                                                          100);
                                                        });
                                                      });
                                                    },
                                                    items: <String>[
                                                      '10%',
                                                      '15%',
                                                      '20%',
                                                      '25%'
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Total Bill : ₹ $totalBillAmount',
                              style: GoogleFonts.montserrat(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 247, 232, 186),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'FOCUS SCORE',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 75,
                                        child: Row(
                                          children: [
                                            Text(
                                              '8.5',
                                              style: TextStyleClass
                                                  .splashScreenTextStyle
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            const Icon(
                                              Icons.star,
                                              color: AppColors.mainThemeColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Good',
                                        style: GoogleFonts.poppins(),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 75,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage:
                                                  AssetImage('assets/wp.png'),
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: AssetImage(
                                                  'assets/insta.png'),
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: AssetImage(
                                                'assets/dribble.jpg',
                                              ),
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: AssetImage(
                                                'assets/yt.png',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Most Used',
                                        style: GoogleFonts.poppins(),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset(
                                        'assets/grapharrow.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Text(
                                        'Way to go! Your screen time this week is 7% less than last week',
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        style:
                                            GoogleFonts.poppins(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AppDefaultButton(
                                bgColor: AppColors.mainThemeColor,
                                onPressed: () {},
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Start Focus Session',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text('Last Session: 2 hours ago',
                                        style: GoogleFonts.poppins(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
