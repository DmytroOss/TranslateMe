import 'package:dart_openai/dart_openai.dart';

class OpenAiService {
  final List<OpenAIChatCompletionChoiceMessageModel> requestMessages = [];

  OpenAiService() {
    OpenAI.apiKey = "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";
    OpenAI.showLogs = true;
    OpenAI.showResponsesLogs = true;
  }

  Future<String?> getResponse(String msg) async {
    requestMessages.add(OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.user,
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(msg)
        ]));

    final model = await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo-1106",
      messages: requestMessages,
    );

    final reply = model.choices.first.message;
    requestMessages.add(reply);

    return reply.content?.first.text;
  }
}
