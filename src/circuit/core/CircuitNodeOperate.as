package circuit.core
{
import net.lists.LinkedList;

public interface CircuitNodeOperate
{
    function get id():String

    function invalidate():void

    function markAsConnected():void

    function validate():void

    function dispatch():void

    function getConnectedCircuits():LinkedList

}
}
