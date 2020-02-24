class RegisterAPIResponse {

    final String message;
    final String username;
    final String email;
    final String profile_img;

    RegisterAPIResponse({ this.message, this.username, this.email, this.profile_img});

    // Summary: the Factory Method design pattern defines an interface for a class responsible for creating an object.

    factory RegisterAPIResponse.fromJson(Map<String, dynamic> json) {
        return RegisterAPIResponse(
            message: json['message'],
            username: json['username'],
            email: json['email'],
            profile_img: json['profile_img']
        );
    }
}
