{ pkgs, lib, secrets, ... }:
# let globalconf = import ../../cfg;
#in
{
  programs = {
    git = {
      enable = true;
      userName = "${secrets.git.username}";
      userEmail = "${secrets.git.email}";

      extraConfig = {
        init.defaultBranch = "main";
        merge.ff = "only";
        push.default = "simple";
        pull.ff = "only";
        rebase.autoSquash = true;
        url."git@github.com:".pushInsteadOf = "https://github.com";
        credential.helper = "store";
      };
      signing = {
        key = "${secrets.git.signing-key}";
        signByDefault = true;
      };
      aliases = {
        a = "add";
        c = "commit";
      };
      # delta = { enable = true; };
      difftastic = {
        enable = true;
        background = "dark";
        color = "always";
      };
    };
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      settings = {
        editor = "lvim";
        git_protocol = "ssh";

        prompt = "enabled";

        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
    };
    gitui = { enable = true; };
  };

  home.file.".config/gptcommit/config.toml".text = ''
    model_provider = "openai"
    allow_amend = false
    file_ignore = ["package-lock.json", "yarn.lock", "pnpm-lock.yaml", "Cargo.lock"]

    [openai]
    api_base = "https://api.openai.com/v1"
    api_key = "${secrets.openai.api-key}"
    #model = "gpt-3.5-turbo-16k"
    retries = 2
    proxy = ""

    [prompt]
    conventional_commit_prefix = """
    You are an expert programmer summarizing a code change.
    You went over every staged file that was changed in it.
    For some of these files changes where too big and were omitted in the files diff summary.
    Determine the best label for the commit. Only include info from the most recent changes.

    Here are the labels you can choose from:

    - build: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
    - chore: Updating libraries, copyrights or other repo setting, includes updating dependencies.
    - ci: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, GitHub Actions)
    - docs: Non-code changes, such as fixing typos or adding new documentation
    - feat: a commit of the type feat introduces a new feature to the codebase
    - fix: A commit of the type fix patches a bug in your codebase
    - perf: A code change that improves performance
    - refactor: A code change that neither fixes a bug nor adds a feature
    - style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
    - test: Adding missing tests or correcting existing tests

    THE FILE SUMMARIES:
    ###
    {{ summary_points }}
    ###

    The label best describing this change:
    """
    commit_summary = """
    You are an expert programmer writing a commit message.
    You went over every staged file that was changed in it.
    For some of these files changes where too big and were omitted in the files diff summary.
    Only include info from the most recent commit.
    Please summarize the commit.
    Write your response in bullet points, using the imperative tense.
    Starting each bullet point with a `-`.
    Write a high level description. Do not repeat the commit summaries or the file summaries.
    Write the most important bullet points. The list should not be more than a few bullet points.

    THE FILE SUMMARIES:
    ```
    {{ summary_points }}
    ```

    Remember to write only the most important points and do not write more than a few bullet points. Only include info from the most recent commit.

    THE COMMIT MESSAGE:
    """
    commit_title = """
    You are an expert programmer writing a commit message title.
    You went over every staged file that was changed in it.
    Some of these files changes were too big, and were omitted in the summaries below.
    Please summarize the commit into a single specific and cohesive theme.
    Write your response using the imperative tense following the kernel git commit style guide.
    Write a high level title. Only include info from the most recent commit.
    Do not repeat the commit summaries or the file summaries.
    Do not list individual changes in the title.

    EXAMPLE SUMMARY COMMENTS:
    ```
    Raise the amount of returned recordings
    Switch to internal API for completions
    Lower numeric tolerance for test files
    Schedule all GitHub actions on all OSs
    ```

    THE FILE SUMMARIES:
    ```
    {{ summary_points }}
    ```

    Remember to write only one line, no more than 50 characters. Only include info from the most recent commit.
    THE COMMIT MESSAGE TITLE:
    """
    file_diff = """
    You are an expert programmer summarizing a git diff.
    Reminders about the git diff format:
    For every file, there are a few metadata lines, like (for example):
    ```
    diff --git a/lib/index.js b/lib/index.js
    index aadf691..bfef603 100644
    --- a/lib/index.js
    +++ b/lib/index.js
    ```
    This means that `lib/index.js` was modified in this commit. Note that this is only an example.
    Then there is a specifier of the lines that were modified. Only include info from the most recent commit.
    A line starting with `+` means it was added.
    A line that starting with `-` means that line was deleted.
    A line that starts with neither `+` nor `-` is code given for context and better understanding.
    It is not part of the diff.
    After the git diff of the first file, there will be an empty line, and then the git diff of the next file.

    Do not include the file name as another part of the comment.
    Do not use the characters `[` or `]` in the summary.
    Write every summary comment in a new line.
    Comments should be in a bullet point list, each line starting with a `-`.
    The summary should not include comments copied from the code.
    The output should be easily readable. When in doubt, write fewer comments and not more. Do not output comments that
    simply repeat the contents of the file.
    Readability is top priority. Write only the most important comments about the diff. And include info from the most recent commit.

    EXAMPLE SUMMARY COMMENTS:
    ```
    - Raise the amount of returned recordings from `10` to `100`
    - Fix a typo in the github action name
    - Move the `octokit` initialization to a separate file
    - Add an OpenAI API for completions
    - Lower numeric tolerance for test files
    - Add 2 tests for the inclusive string split function
    ```
    Most commits will have less comments than this examples list.
    The last comment does not include the file names,
    because there were more than two relevant files in the hypothetical commit.
    Do not include parts of the example in your summary. Include info from the most recent commit only.
    It is given only as an example of appropriate comments.

    THE GIT DIFF TO BE SUMMARIZED:
    ```
    {{ file_diff }}
    ```

    THE SUMMARY:
    """
    translation = """
    You are a professional polyglot programmer and translator. You are translating a git commit message.
    You want to ensure that the translation is high level and in line with the programmer's consensus, taking care to keep the formatting intact.

    Translate the following message into {{ output_language }}.

    GIT COMMIT MESSAGE:

    ###
    {{ commit_message }}"\n"; git commit message.
    THE TRANSLATION:
    """

    [output]
    conventional_commit = true
    conventional_commit_prefix_format = "{{ prefix }}: "
    lang = "en"
    show_per_file_summary = true

  '';

}
