package circuit.core
{
import net.lists.LinkedList;

public interface CircuitOperate
{
    function invalidate():void

    function markAsConnected():void

    function validate():void

    function getConnectedCircuits():LinkedList

}
}
