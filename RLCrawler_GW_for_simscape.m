[10 -15 -40 -65 -90; 90 60 30 0 -30]
ser1 = [10 -15 -40 -65 -90];
ser2 = [90 60 30 0 -30];

clear all

                   
obsInfo = rlFiniteSetSpec({[10,90]';[10,60]';[10,30]';[10,0]';[10,-30]';
                           [-15,90]';[-15,60]';[-15,30]';[-15,0]';[-15,-30]';
                           [-40,90]';[-40,60]';[-40,30]';[-40,0]';[-40,-30]';
                           [-65,90]';[-65,60]';[-65,30]';[-65,0]';[-65,-30]';
                           [-90,90]';[-90,60]';[-90,30]';[-90,0]';[-90,-30]'});                 
obsInfo.Name = 'observations';
obsInfo.Description = 'Servo 1, Servo 2';
numObservations = obsInfo.Dimension(1);

actInfo = rlFiniteSetSpec([1 2 3 4]'); %N S W E
actInfo.Name = 'Position Servo 1, Position Servo 2';
numActions = actInfo.Dimension(1);  

Ts = 1; %Sampletime %1
Tf = 100; %Simulationtime %100
env = rlSimulinkEnv('Crawler_Simscape','Crawler_Simscape/RL Agent',...
    obsInfo,actInfo);

qTable = rlTable(getObservationInfo(env), getActionInfo(env));
tableRep = rlRepresentation(qTable);
tableRep.Options.LearnRate = 0.05; %0.1

agentOpts = rlQAgentOptions;
agentOpts.SampleTime = Ts;
agentOpts.EpsilonGreedyExploration.Epsilon = 0.7; %0.7
agentOpts.EpsilonGreedyExploration.EpsilonMin = 0.1; %0.01
agentOpts.EpsilonGreedyExploration.EpsilonDecay = 0.00005; %0.08
agent = rlQAgent(tableRep, agentOpts);

trainOpts = rlTrainingOptions;
trainOpts.MaxStepsPerEpisode = ceil(Tf/Ts);
trainOpts.MaxEpisodes= 5000;
trainOpts.StopTrainingCriteria = "AverageReward";
trainOpts.StopTrainingValue = 2500;
trainOpts.ScoreAveragingWindowLength = 30;
%trainOpts.StopOnError = "off";

trainingStats = train(agent,env,trainOpts);
%generatePolicyFunction(agent)