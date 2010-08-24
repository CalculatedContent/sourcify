require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from do ... end block (w nested module)" do

  should 'handle simple' do
    (
      lambda do
        module AA
          def aa
            @x1 = 1
          end
        end
      end
    ).should.be having_code(%Q\
      proc do
        module AA
          def aa
            @x1 = 1
          end
        end
      end
    \)
  end

  should 'handle nested' do
    (
      lambda do
        module AA
          module BB
            def bb
              @x1 = 1
            end
          end
        end
      end
    ).should.be having_code(%Q\
      proc do
        module AA
          module BB
            def bb
              @x1 = 1
            end
          end
        end
      end
    \)
  end

end