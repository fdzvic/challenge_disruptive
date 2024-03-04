// ignore_for_file: public_member_api_docs, sort_constructors_first
class ButtonsLoginState {
  int? id;

  ButtonsLoginState({
    this.id = 1,
  });

  ButtonsLoginState copyWith({
    int? id,
  }) {
    return ButtonsLoginState(id: id ?? this.id);
  }
}
