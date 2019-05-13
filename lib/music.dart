class Music {
  var _title,_musicUri,_imageUri, _description;
  Music(this._title,this._musicUri,this._imageUri,this._description);

  String get title => _title;
  String get musicUri => _musicUri;
  String get imageUri => _imageUri;
  String get description => _description;
}