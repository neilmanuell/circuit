package circuit.signals
{
import circuit.api.Supply;

import net.richardlord.ash.signals.Signal1;

public class PowerSupplyChangedSignal extends Signal1
{
    public function PowerSupplyChangedSignal()
    {
        super( Supply );
    }

    public function dispatchPowerSupply( value:Supply ):void
    {
        dispatch( value );
    }
}
}
