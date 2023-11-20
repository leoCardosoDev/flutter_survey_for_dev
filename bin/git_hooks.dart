import "package:flutter/material.dart";
import "package:git_hooks/git_hooks.dart";
import "dart:io";

void main(List<String> arguments) {
  Map<Git, UserBackFun> params = {
    Git.commitMsg: commitMsg,
    Git.preCommit: preCommit
  };
  GitHooks.call(arguments, params);
}

Future<bool> commitMsg() async {
  String commitMsg = Utils.getCommitEditMsg();
  if (commitMsg.startsWith('fix:')) {
    return true;
  } else {
    return false;
  }
}

Future<bool> preCommit() async {
  try {
    ProcessResult result = await Process.run('dartanalyzer', ['bin']);
    debugPrint(result.stdout);
    if (result.exitCode != 0) return false;
  } catch (e) {
    return false;
  }
  return true;
}
