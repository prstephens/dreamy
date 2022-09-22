
use builtin;
use str;

set edit:completion:arg-completer[swww] = {|@words|
    fn spaces {|n|
        builtin:repeat $n ' ' | str:join ''
    }
    fn cand {|text desc|
        edit:complex-candidate $text &display=$text' '(spaces (- 14 (wcswidth $text)))$desc
    }
    var command = 'swww'
    for word $words[1..-1] {
        if (str:has-prefix $word '-') {
            break
        }
        set command = $command';'$word
    }
    var completions = [
        &'swww'= {
            cand -h 'Print help information'
            cand --help 'Print help information'
            cand -V 'Print version information'
            cand --version 'Print version information'
            cand clear 'Fills the specified outputs with the given color'
            cand img 'Send an image (or animated gif) for the daemon to display'
            cand init 'Initialize the daemon'
            cand kill 'Kills the daemon'
            cand query 'Asks the daemon to print output information (names and dimensions)'
            cand help 'Print this message or the help of the given subcommand(s)'
        }
        &'swww;clear'= {
            cand -o 'Comma separated list of outputs to display the image at'
            cand --outputs 'Comma separated list of outputs to display the image at'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'swww;img'= {
            cand -o 'Comma separated list of outputs to display the image at'
            cand --outputs 'Comma separated list of outputs to display the image at'
            cand -f 'Filter to use when scaling images (run swww img --help to see options)'
            cand --filter 'Filter to use when scaling images (run swww img --help to see options)'
            cand -t 'Sets the type of transition. Default is ''simple'', that fades into the new image'
            cand --transition-type 'Sets the type of transition. Default is ''simple'', that fades into the new image'
            cand --transition-step 'How fast the transition approaches the new image'
            cand --transition-speed 'How fast the transition ''sweeps'' through the screen'
            cand --transition-fps 'Frame rate for the transition effect'
            cand --transition-cord-x 'X cordinate to use as center for the transition'
            cand --transition-cord-y 'Y cordinate to use as center for the transition'
            cand --transition-speed-step 'value to increase the total speed by every frame'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'swww;init'= {
            cand --no-daemon 'Don''t fork the daemon. This will keep it running in the current terminal'
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'swww;kill'= {
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'swww;query'= {
            cand -h 'Print help information'
            cand --help 'Print help information'
        }
        &'swww;help'= {
        }
    ]
    $completions[$command]
}
