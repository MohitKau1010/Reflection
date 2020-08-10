class StoreListData {
    String message;
    int statusCode;
    List<Story> stories;

    StoreListData({this.message, this.statusCode, this.stories});

    factory StoreListData.fromJson(Map<String, dynamic> json) {
        return StoreListData(
            message: json['message'], 
            statusCode: json['statusCode'], 
            stories: json['stories'] != null ? (json['stories'] as List).map((i) => Story.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['statusCode'] = this.statusCode;
        if (this.stories != null) {
            data['stories'] = this.stories.map((v) => v.toJson()).toList();
        }
        return data;
    }


}

class Story {
    String _id;
    int createdAt;
    String name;
    int updatedAt;

    Story({/*this._id,*/this.createdAt, this.name, this.updatedAt});

    factory Story.fromJson(Map<String, dynamic> json) {
        return Story(
            //_id: json['_id'],
            createdAt: json['createdAt'],
            name: json['name'],
            updatedAt: json['updatedAt'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this._id;
        data['createdAt'] = this.createdAt;
        data['name'] = this.name;
        data['updatedAt'] = this.updatedAt;
        return data;
    }
}