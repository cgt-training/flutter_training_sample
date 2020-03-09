import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_training_app/models/redux/app_state.dart';
import 'package:flutter_training_app/response_model/loginResponse.dart';
import 'package:flutter_training_app/screens/screen_props/login_props.dart';
import 'package:redux/redux.dart';

class Profile extends StatelessWidget{
    LoginAPIResponse loginAPIResponse;

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        
        topContentItems(LoginProps props){
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.network(
                            'https://www.jing.fm/clipimg/detail/64-644721_gambar-ukuran-100x100-pixel.png',
                            height: 100,
                            width: 100,
//                                        image: AssetImage('assets/images/profile.png')
                        ),
                    ),
                    SizedBox(
                        height: 10,
                    ),
                    Text(
                        props.apiResponse.email,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                    ),
                    SizedBox(
                        height: 10,
                    ),
                    Text(
                        props.apiResponse.role == 1 ? 'Role: ADMIN': 'Role: APP_USER',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                        ),
                    )
                ],
            );
        } 
        
        topContent (LoginProps props) {
          return Stack(
            children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * .4,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(1.0, 1.0),
                            colors: [Color(0xFFD6D6D6), Color(0xFFBDBDBD), Color(0xFF9E9E9E), Color(0xFF757575), Color(0xFF616161), Color(0xFF424242)],
                            tileMode: TileMode.repeated
                        )
                    ),
                ),
                Container(

                    height: MediaQuery.of(context).size.height * .4,
                    child: Center(
                        child: topContentItems(props)
                        
                    )
                )
            ],
          );
        }

        bottomContentItem(String props, String message){
            return Card(
                color: Color(0xFF623e8e),
                child: Container(
                    padding: EdgeInsets.only(left: 40, right: 40) ,
                    width: MediaQuery.of(context).size.width * .8,
                    height: MediaQuery.of(context).size.height *.1,
                    child: Row(
                        children: <Widget>[
                            Text(
                                message,
                                style: TextStyle(
                                    color: Color(0xFFc8cdd1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                            ),
                            Expanded(
                                child: Text(
                                    props,
                                    style: TextStyle(
                                        color: Color(0xFFc8cdd1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                ),
                            )

                        ],
                    )
                ),
            );
        }

        bottomContent(LoginProps props){
            return Container(
                padding: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.height * .5,
//                decoration: BoxDecoration(
//                    color: Color(0xFFD6D6D6),
//                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        bottomContentItem(props.apiResponse.message, 'Message: '),
                        SizedBox(
                            height:  50,
                        ),
                        bottomContentItem(props.apiResponse.token, 'Token: '),
                    ],
                )

            );
        }

        return StoreConnector<AppState, LoginProps>(
            converter: (Store<AppState> store){
                return LoginProps.mapStateToProps(store);
            }, builder: (BuildContext context, props) {
                return Scaffold(
                    body: Column(
                        children: <Widget>[
                            topContent(props),
                            bottomContent(props)
                        ],
                    ),
                );
            },
        );

    }


}