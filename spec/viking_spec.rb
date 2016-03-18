require "viking"

describe Viking do
  let(:john) {Viking.new("John")}
  describe "#initialize" do
    it "should name a viking by its pass name" do
      expect(john.name).to eq("John")
    end

    it "should add health if initialize with" do
      john = Viking.new("John", 150)
      expect(john.health).to eq(150) 
    end
  end

  describe "#health=" do
    it "should raise an error if try to modify" do
      expect{john.health = 150}.to raise_error(NoMethodError)
    end
  end

  describe "#weapon" do
    it "should eq nil when Viking initialize" do
      expect(john.weapon).to be_nil
    end
  end

  describe "#pick_up_weapon" do
    describe "A real weapon" do
      it "should pick a weapon" do
        bow = Bow.new
        john.pick_up_weapon(bow)
        expect(john.weapon).to eq(bow)
      end
    end

    describe "Not a real weapon" do
      it "should raise exception if not a eapon" do
        not_a_weapon = "String"
      
        expect{john.pick_up_weapon(not_a_weapon)}.to raise_error(RuntimeError)
      end
    end

    describe "if already get weapon" do
      it "should set new weapon" do
        bow = Bow.new
        john.pick_up_weapon(bow)
        axe = Axe.new
        john.pick_up_weapon(axe)
        expect(john.weapon).to eq(axe)
      end
    end
  end

  describe "#drop_weapon" do
    it "should leave the Viking weaponless" do
      bow = Bow.new
      john.pick_up_weapon(bow)
      john.drop_weapon
      expect(john.weapon).to be_nil
    end
  end

  describe "#receive_attack" do
    it "should reduce the health of the Viking" do
      john.receive_attack(30)
      expect(john.health).to eq(70)
    end

    it "should call #take_damage" do
      expect(john).to receive(:take_damage)

      john.receive_attack(30)
    end
  end

  describe "#attack" do
    let(:sven) {Viking.new("Sven")}
    it "should lower the health of the recipient" do
      john.attack(sven)

      expect(sven.health).to be < 100
    end

    it "should call #take_damage on the receiver" do
      expect(sven).to receive(:take_damage)

      john.attack(sven)
    end

    it "without weapon should call #damage_with_fists" do
      expect(john).to receive(:damage_with_fists).and_return(2.5)
      john.attack(sven)
    end

    it "without weapon to eq fist multiplier time strength" do
      john.attack(sven)
      expect(sven.health).to eq(97.5)
    end

    it "with a weapon should call #damage_with_weapon" do
      bow = Bow.new
      john.pick_up_weapon(bow)
      expect(john).to receive(:damage_with_weapon).and_return(20)

      john.attack(sven)
    end

    it "with a weapon to eq weapon multiplier time strength" do
      bow = Bow.new
      john.pick_up_weapon(bow)
      john.attack(sven)

      expect(sven.health).to eq(80)
    end

    it "without enough arrow use fists" do
      bow = Bow.new(0)
      john.pick_up_weapon(bow)

      expect(john).to receive(:damage_with_fists).and_return(2.5)

      john.attack(sven)
    end

    it "and killing Viking raise an error" do
      allow(john).to receive(:damage_with_fists).and_return(150)
      expect{john.attack(sven)}.to raise_error(RuntimeError)
    end
  end
end













