// Summary: Provides the response object for comments API.
class CommentsResponse{

    int postId;
    int id;
    String name;
    String email;
    String body;

    CommentsResponse({
        this.postId,
        this.id,
        this.name,
        this.email,
        this.body
    });

    // Summary: Convert the response data from the API into comments object.
    factory CommentsResponse.fromJson(dynamic json){

        return CommentsResponse(
            postId: json['postId'],
            id: json['id'],
            name: json['name'],
            email: json['email'],
            body: json['body']
        );
    }

    // Summary: Map the comment object to properties in the object before inserting into database.
    Map<String, dynamic> toMap(){

        return{
            'postId': postId,
            'id': id,
            'name': name,
            'email': email,
            'body': body
        };

    }
}