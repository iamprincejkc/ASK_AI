import 'package:ask_ai/feature_box.dart';
import 'package:ask_ai/openai_service.dart';
import 'package:ask_ai/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      print(lastWords);
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //VA Picture
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/virtualAssistant.png'),
                    ),
                  ),
                )
              ],
            ),

            //Chat Bubble
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin:
                  const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor,
                ),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Good morning, what task can I do for you ?',
                  style: TextStyle(
                    fontFamily: Constants.mainFont,
                    color: Pallete.mainFontColor,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 10, left: 22),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Here are a few features',
                style: TextStyle(
                  fontFamily: Constants.mainFont,
                  color: Pallete.mainFontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //Features List
            Column(
              children: const [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headearText: 'ChatGPT',
                  descriptionText:
                      'A smarter way to stay organized and informed with ChatGPT',
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headearText: 'Dall-E',
                  descriptionText:
                      'Get inspired and stay creative with your personal assistant powered by Dall-E',
                ),
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headearText: 'Smart Voice Assistant',
                  descriptionText:
                      'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            await openAIService.isArtPromptAPI(lastWords);
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: const Icon(
          Icons.mic,
          color: Pallete.blackColor,
        ),
      ),
    );
  }
}
