package circuit.api
{
public interface Edge extends Element
{
    function get isClosed():Boolean

    function open():void

    function close():void

}
}
