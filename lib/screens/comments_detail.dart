import 'package:flutter/material.dart';

// Response Model
import 'package:flutter_training_app/response_model/comments_response.dart';

// Summary: This will create the detail page for comments with comment object is passed.
class CommentsDetail extends StatelessWidget{

    static CommentsResponse comments;

    CommentsDetail(CommentsResponse commentsdata){
        print("CommentsDetail(CommentsResponse comments)");
        print(commentsdata);
        comments = commentsdata;
    }

    @override
    Widget build(BuildContext context) {

        final commentID = Container(
            padding: const EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5.0)
            ),
            child: new Text(
                "CId: " + comments.id.toString(),
                style: TextStyle(color: Colors.white),
            ),
        );

        final topContentText = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                SizedBox(height: 50.0),
                Icon(
                    Icons.local_post_office,
                    color: Colors.white,
                    size: 40.0,
                ),
                Container(
                    width: 90.0,
                    child: new Divider(color: Colors.green),
                ),
                SizedBox(height: 10.0),
                Expanded(
                    child: Text(
                        comments.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                    ),
                ),

                SizedBox(height: 30.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                        Expanded(
                            flex: 6,
                            child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                    comments.email,
                                    style: TextStyle(color: Colors.white),
                                )
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: commentID
                        )
                    ],
                ),
            ],
        );

        final topContent = Stack(
            children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: new AssetImage('assets/images/comments.jpg'),
                            fit: BoxFit.cover,
                        ),
                    )),
                Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.all(40.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .8)),
                    child: Center(
                        child: topContentText,
                    ),
                ),
                Positioned(
                    left: 8.0,
                    top: 60.0,
                    // Summary: InkWell rectangular area of a Material that responds to touch.
                    child: InkWell(
                        onTap: () {
                            Navigator.pop(context);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 25,
                            ),
                        )

                    ),
                )
            ],
        );

        final bottomContentText = Text(
            comments.body + comments.body,
            style: TextStyle(
                fontSize: 18.0
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 10,
            textAlign: TextAlign.justify,
        );

        final bottomContent = Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(40.0),
            child: Center(
                child: Column(
                    children: <Widget>[bottomContentText],
                ),
            ),
        );


        // TODO: implement build
        return Scaffold(
            body: Column(
                children: <Widget>[topContent, bottomContent],
            ),
        );
    }

}
