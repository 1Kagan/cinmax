import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_in_touch_state.dart';

class FormCubit extends Cubit<FormState> {
  FormCubit(super.initialState);

  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? phoneController;


  void generateController(){
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    nameController?.addListener(() {
      updateName(nameController?.text ?? '');
    });
    emailController?.addListener(() {
      updateEmail(emailController?.text ?? '');
    });
    phoneController?.addListener(() {
      updatePhone(phoneController?.text ?? '');
    });
  }



  void updateName(String name) => emit(state.copyWith(name: name));
  void updateEmail(String email) => emit(state.copyWith(email: email));
  void updatePhone(String phone) => emit(state.copyWith(phone: phone));
  void toggleAcceptance(bool isAccepted) =>
      emit(state.copyWith(isAccepted: isAccepted));

}
