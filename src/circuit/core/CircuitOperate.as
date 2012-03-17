package circuit.core
{
public interface CircuitOperate
{
    function invalidate(): void

    function markAsConnected():void

    function validate():void

    function getConnectedCircuits(  ):Array

}
}
