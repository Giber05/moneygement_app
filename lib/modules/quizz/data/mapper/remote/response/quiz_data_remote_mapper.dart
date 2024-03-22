import 'package:moneygement_app/infrastructure/types/mapper/json_mapper.dart';
import 'package:moneygement_app/modules/quizz/domain/models/quiz_data.dart';

class QuizDataMapper implements FromJSONMapper<QuizDataModel> {
  @override
  QuizDataModel toModel(json) {
    return QuizDataModel(
      text: json['text'],
      name: json['name'],
      value: json['value'],
    );
  }
}
