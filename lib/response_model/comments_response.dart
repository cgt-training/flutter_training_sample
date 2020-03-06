// Summary: Provides the response object for comments API.
class CommentsResponse{

    final int postId;
    final int id;
    final String name;
    final String email;
    final String body;

    CommentsResponse({
        this.postId,
        this.id,
        this.name,
        this.email,
        this.body
    });

    factory CommentsResponse.fromJson(dynamic json){

        return CommentsResponse(
            postId: json['postId'],
            id: json['id'],
            name: json['name'],
            email: json['email'],
            body: json['body']
        );
    }
}