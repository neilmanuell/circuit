package circuit.base
{
import circuit.api.PowerSupply;
import circuit.signals.PowerSupplyChangedSignal;

public class PowerSupplyGroup
{
    private const _powerSupply:Array = [];
    private const _onStateChanged:PowerSupplyChangedSignal = new PowerSupplyChangedSignal();


    public function get onStateChanged():PowerSupplyChangedSignal
    {
        return _onStateChanged;
    }

    public function add( powerSupply:PowerSupply ):Boolean
    {
        if ( has( powerSupply ) )return false
        _powerSupply.push( powerSupply );
        powerSupply.onStateChanged.add( handleChildStateChange );
        return true;
    }

    private function handleChildStateChange( powerSupply:PowerSupply ):void
    {
        _onStateChanged.dispatchPowerSupply( powerSupply );
    }

    public function has( powerSupply:PowerSupply ):Boolean
    {
        return (_powerSupply.indexOf( powerSupply ) != -1);
    }


    public function getActive():Array
    {
        const a:Array = [];
        for each ( var supply:PowerSupply in _powerSupply )
            if ( supply.isOn ) a.push( supply )
        return a;
    }
}
}
