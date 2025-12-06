[![progress-banner](https://backend.codecrafters.io/progress/shell/d4fb8da2-efa3-46a1-a604-03519556c2fd)](https://app.codecrafters.io/users/codecrafters-bot?r=2qF)

This is a starting point for Ruby solutions to the
["Build Your Own Shell" Challenge](https://app.codecrafters.io/courses/shell/overview).

In this challenge, you'll build your own POSIX compliant shell that's capable of
interpreting shell commands, running external programs and builtin commands like
cd, pwd, echo and more. Along the way, you'll learn about shell command parsing,
REPLs, builtin commands, and more.

**Note**: If you're viewing this repo on GitHub, head over to
[codecrafters.io](https://codecrafters.io) to try the challenge.

## Adding a new command
1. Build your command class inheriting from basic, builtin, etc
2. Ensure new class located in the commands directory
3. For built-ins, update the BUILTIN_LOOKUP and BUILTIN_COMMAND