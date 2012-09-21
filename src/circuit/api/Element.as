package circuit.api
{
import net.richardlord.ash.signals.Signal1;

public interface Element
{
    function get onStateChanged():Signal1

    function get id():String

}
}
