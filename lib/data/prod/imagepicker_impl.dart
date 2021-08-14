import 'dart:io';

import 'package:chatter/data/image_picker_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerImpl extends ImagePickerRepository{
  @override
  Future<File> pickImage() async{
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
    return File(pickedFile.path);  
    }else throw Text('Pickedfile does\'n exist');
  
  }

}