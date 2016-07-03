
classdef TestAdditiveNoiseSystemModel < matlab.unittest.TestCase
    % Provides unit tests for the AdditiveNoiseSystemModel class.
    
    % >> This function/class is part of the Nonlinear Estimation Toolbox
    %
    %    For more information, see https://bitbucket.org/nonlinearestimation/toolbox
    %
    %    Copyright (C) 2015  Jannik Steinbring <jannik.steinbring@kit.edu>
    %
    %                        Institute for Anthropomatics and Robotics
    %                        Chair for Intelligent Sensor-Actuator-Systems (ISAS)
    %                        Karlsruhe Institute of Technology (KIT), Germany
    %
    %                        http://isas.uka.de
    %
    %    This program is free software: you can redistribute it and/or modify
    %    it under the terms of the GNU General Public License as published by
    %    the Free Software Foundation, either version 3 of the License, or
    %    (at your option) any later version.
    %
    %    This program is distributed in the hope that it will be useful,
    %    but WITHOUT ANY WARRANTY; without even the implied warranty of
    %    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    %    GNU General Public License for more details.
    %
    %    You should have received a copy of the GNU General Public License
    %    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    methods (Test)
        function testSimulate(obj)
            sysModel = AddNoiseSysModel();
            sysModel.setNoise(Uniform([0 0], [1 1]));
            
            detSimState = sysModel.sysMatrix * TestUtilsAdditiveNoiseSystemModel.initMean;
            
            simState = sysModel.simulate(TestUtilsAdditiveNoiseSystemModel.initMean);
            
            obj.verifyEqual(size(simState), [2 1]);
            obj.verifyGreaterThanOrEqual(simState, detSimState);
            obj.verifyLessThanOrEqual(simState, detSimState + 1);
        end
        
        
        function testDerivative(obj)
            sysModel = AddNoiseSysModel();
            
            nominalState = [-3 0.5]';
            
            stateJacobian = sysModel.derivative(nominalState);
            
            obj.verifyEqual(stateJacobian, sysModel.sysMatrix, 'AbsTol', 1e-8);
        end
    end
end
