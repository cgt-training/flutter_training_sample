// Summary: This class will create a model to fetch the API response for posts.

class PostsResponse{

    final int userId;
    final int id;
    final String title;
    final String body;

    PostsResponse({
        this.userId,
        this.id,
        this.title,
        this.body
    });

    // Summary: Factory method will create an interface.
    factory PostsResponse.fromJson(Map<String, dynamic> json){
        return PostsResponse(
            userId: json['userId'],
            id: json['id'],
            title: json['title'],
            body: json['body']
        );
    }
}

