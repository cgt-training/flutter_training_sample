class LoginAPIResponse {

    final bool success;
    final String message;
    final String token;
    final String email;
    final int role;

    LoginAPIResponse({this.success, this.message, this.token, this.email, this.role});

    factory LoginAPIResponse.fromJson(Map<String, dynamic> json) {
        return LoginAPIResponse(
            success: json['success'],
            message: json['message'],
            token: json['token'],
            email: json['email'],
            role: json['role']
        );
    }
}