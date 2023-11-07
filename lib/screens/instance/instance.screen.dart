import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/bloc/product/product.bloc.dart';
import 'package:maxcloud/screens/instance/instance.detail.screen.dart';
import 'package:maxcloud/utils/widgets.dart';

class InstanceScreen extends StatefulWidget {
  const InstanceScreen({super.key});

  @override
  State<InstanceScreen> createState() => _InstanceScreenState();
}

class _InstanceScreenState extends State<InstanceScreen> {
  ProductBloc? productBloc;

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);

    getAccessToken();
    super.initState();
  }

  void getAccessToken() async {
    String? accessToken = await storage.read(key: 'accessToken');
    productBloc?.add(FetchProductEvent(accessToken ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Instances",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        color: Color(0xff353333),
                        fontSize: 25,
                        fontWeight: FontWeight.w600))),
          ],
        ),
        // leading: IconButton(
        //   icon: SvgPicture.asset('assets/svg/icons/ios-back.svg',
        //       height: 24, fit: BoxFit.scaleDown),
        //   onPressed: () {},
        // ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is LoadedProductState) {
            LoadedProductState instances = state;

            return SafeArea(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              child: Column(
                children: [
                  Row(
                    children: [
                      // Flexible(
                      //   flex: 3,
                      //   child: MaterialButton(
                      //     minWidth: 171.w,
                      //     height: 30.h,
                      //     elevation: 0,
                      //     color: Color(0xff009EFF),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) =>
                      //                   InstanceCreateScreen()));
                      //     },
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         SvgPicture.asset('assets/svg/icons/plus-icon.svg',
                      //             height: 11.h, fit: BoxFit.scaleDown),
                      //         SizedBox(width: 12.w),
                      //         Text(
                      //           "Create Instance",
                      //           style: GoogleFonts.manrope(
                      //               textStyle: TextStyle(
                      //                   fontSize: 14.sp,
                      //                   color: Colors.white,
                      //                   fontWeight: FontWeight.w400)),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Flexible(flex: 3, child: Container()),
                      const Spacer(),
                      Flexible(
                        flex: 2,
                        child: MaterialButton(
                          height: 30.h,
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(width: 1, color: Color(0xffBBBBBB)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Filter",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: const Color(0xff353333),
                                        fontWeight: FontWeight.w400)),
                              ),
                              const SizedBox(width: 30),
                              SvgPicture.asset('assets/svg/icons/filter.svg',
                                  height: 15.h, fit: BoxFit.scaleDown),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  instances.products.data!.data!.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: instances.products.data!.data!.map((e) {
                              return CustomWidget.InstanceSpecs(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InstanceDetailScreen(data: e)));
                              }, data: e);
                            }).toList(),
                          ),
                        )
                      : Flexible(
                          child: SizedBox(
                            height: ScreenUtil().screenHeight,
                            width: ScreenUtil().screenWidth,
                            child: const Center(
                              child: Text("There is no instances"),
                            ),
                          ),
                        ),
                ],
              ),
            ));
          }
          // else if (state is LoadingProductState) {
          //   return CustomWidget.loader();
          // }
          else if (state is ErrorProductState) {
            return SizedBox(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              child: const Center(
                child: Text(
                  "Error occured, please contact administrator",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
