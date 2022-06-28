class ApiResponse {
  final String token;
  final bool message;

  ApiResponse(this.token, this.message);

  ApiResponse.fromJson(Map<String,dynamic> json):
       message = json['auth'],
        token = json['token'];
  
}