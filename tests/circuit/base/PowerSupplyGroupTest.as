package circuit.base
{

import circuit.api.PowerSupply;
import circuit.signals.BreakerStateChangedSignal;
import circuit.signals.PowerSupplyChangedSignal;

import org.hamcrest.assertThat;
import org.hamcrest.object.instanceOf;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.strictlyEqualTo;

public class PowerSupplyGroupTest
{
    private var _powerSupplyA:PowerSupply;
    private var _powerSupplyB:PowerSupply;
    private var _powerSupplyC:PowerSupply;

    private var _receivedPowerSupply:PowerSupply;
    private var _classUnderTest:PowerSupplyGroup;


    [Before]
    public function before():void
    {
        _powerSupplyA = new SimplePowerSupply();
        _powerSupplyB = new SimplePowerSupply();
        _powerSupplyC = new SimplePowerSupply();

        _classUnderTest = new PowerSupplyGroup();
    }

    [After]
    public function after():void
    {
        _powerSupplyA = null;
        _powerSupplyB = null;
        _powerSupplyC = null;
        _classUnderTest = null;
    }

    [Test]
    public function has__by_default_returns_false():void
    {
        assertThat( _classUnderTest.has( _powerSupplyA ), isFalse() );
    }

    [Test]
    public function add__registers_breaker():void
    {
        _classUnderTest.add( _powerSupplyA );
        assertThat( _classUnderTest.has( _powerSupplyA ), isTrue() );
    }

    [Test]
    public function successful_add__returns_true():void
    {
        assertThat( _classUnderTest.add( _powerSupplyA ), isTrue() );
    }

    [Test]
    public function duplicate_add__returns_false():void
    {
        _classUnderTest.add( _powerSupplyA );
        assertThat( _classUnderTest.add( _powerSupplyA ), isFalse() );
    }

    [Test]
    public function getActive_returns_instanceOf_Array():void
    {
        fillGroup();
        assertThat( _classUnderTest.getActive(  ), instanceOf( Array) );
    }

    [Test]
    public function onStateChanged_returns_instanceOf_PowerSupplyChangedSignal():void
    {
        assertThat( _classUnderTest.onStateChanged, instanceOf( PowerSupplyChangedSignal ) );
    }

    [Test]
    public function onStateChanged_dispatches_when_closed_child_opens():void
    {
        fillGroup();
        _classUnderTest.onStateChanged.add( breakerListener );
        _powerSupplyB.switchOn();
        assertThat( _receivedPowerSupply, strictlyEqualTo( _powerSupplyB ) );
    }

    [Test]
    public function onStateChanged_dispatches_when_open_child_closes():void
    {
        fillGroup();
        _powerSupplyC.switchOn();
        _classUnderTest.onStateChanged.add( breakerListener );
        _powerSupplyC.switchOff();
        assertThat( _receivedPowerSupply, strictlyEqualTo( _powerSupplyC ) );
    }

    private function breakerListener( powerSupply:PowerSupply ):void
    {
        _receivedPowerSupply = powerSupply;
    }

    private function fillGroup():void
    {
        _classUnderTest.add( _powerSupplyA );
        _classUnderTest.add( _powerSupplyB );
        _classUnderTest.add( _powerSupplyC );
    }


}
}
