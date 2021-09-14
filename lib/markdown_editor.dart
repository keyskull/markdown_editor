import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

Map<String, String> textData = {};

class MarkdownEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = Random().nextInt(1000);
    final iFrame = html.IFrameElement();
    final editor = iFrame.ownerDocument!.querySelector("#editor");
    iFrame.srcdoc = """
    <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
    <div id='editor'></div>
    <script>
    const Editor = toastui.Editor;
    const editor = new Editor({
      el: document.querySelector('#editor'),
      height: 'auto',
      initialEditType: 'markdown',
      previewStyle: 'vertical'
    });

    document.getElementById("editor").addEventListener("change", (function(){

    }));
    editor.getMarkdown();
    </script>
        """;

    editor?.innerText = textData[this.hashCode.toString()] ?? "";
    editor?.addEventListener('change', (event) {
      textData[this.hashCode.toString()] = editor.innerText;
    });

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        'markdown-editor' + id.toString(),
        (int viewId) => iFrame
          ..width = '640'
          ..height = '360'
          ..style.border = 'none');

    return HtmlElementView(viewType: 'markdown-editor' + id.toString());
  }
}
