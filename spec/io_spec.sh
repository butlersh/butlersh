Describe 'io_line'
    Include src/lib/io.sh

    It 'parses success tag'
        When call io_line 'I am trying <success>ShellSpec</success>'
        The output should equal '-e I am trying ShellSpec'
    End

    It 'parses info tag'
        When call io_line 'I am trying <info>ShellSpec</info>'
        The output should equal '-e I am trying ShellSpec'
    End

    It 'parses comment tag'
        When call io_line 'I am trying <comment>ShellSpec</comment>'
        The output should equal '-e I am trying ShellSpec'
    End

    It 'parses error tag'
        When call io_line 'I am trying <error>ShellSpec</error>'
        The output should equal '-e I am trying ShellSpec'
    End
End
