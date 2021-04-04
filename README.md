# slide2mp4

slide2mp4 is a conversion tool, PDF slides to MP4 with audio and subtitles.   
slide2mp4 uses Amazon Polly, Text-to-Speech (TTS) service.

----
## Requirements

 - [AWS CLI version 2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) (version 1 has not been tested.)
 - Permission to run [Amazon Polly](https://aws.amazon.com/jp/polly/) service with AWS CLI
 - [FFmpeg](https://www.ffmpeg.org/)
 - [GraphicsMagick](http://www.graphicsmagick.org/index.html)
 - [Ghostscript](https://www.ghostscript.com/)
 - [Python 3](https://www.python.org/)
 - [xmllint](http://xmlsoft.org/xmllint.html)

If you use Linux or macOS(including M1 Mac), you can install AWS CLI, FFmpeg, GraphicsMagick, Ghostscript with [Homebrew](https://brew.sh/).

```
brew install awscli ffmpeg ghostscript graphicsmagick
```

----
## How to use

The following command creates one mp4 file with audio and subtitles, named "test-output.mp4".

```
chmod u+x slide2mp4.sh
./slide2mp4.sh test-slides.pdf test-slides.txt test-lexicon.pls test-output.mp4
```

If you have modified some of the slides, e.g. pages 2 and 3, you can apply the patch to the "test-output.mp4" with the following command.

```
./slide2mp4.sh test-slides.pdf test-slides.txt test-lexicon.pls test-output.mp4 "2 3"
```

----
## Documentation
 - [Japanese User Guide](https://github.com/h-kojima/slide2mp4/blob/main/doc/userguide-ja.md)

----
## License
 - [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
