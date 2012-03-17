package circuit.base
{
import circuit.api.Breaker;
import circuit.signals.BreakerStateChangedSignal;

public class BreakerGroup
{
    private const _breakers:Array = [];
    private const _onStateChanged:BreakerStateChangedSignal = new BreakerStateChangedSignal();


    public function get onStateChanged():BreakerStateChangedSignal
    {
        return _onStateChanged;
    }

    public function add( breaker:Breaker ):Boolean
    {
        if ( has( breaker ) )return false
        _breakers.push( breaker );
        breaker.onStateChanged.add( handleChildStateChange );
        return true;
    }

    private function handleChildStateChange( breaker:Breaker ):void
    {
        _onStateChanged.dispatchBreaker( breaker );
    }

    public function has( breaker:Breaker ):Boolean
    {
        return (_breakers.indexOf( breaker ) != -1);
    }


}
}
