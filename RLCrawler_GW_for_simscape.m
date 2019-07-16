[10 -15 -40 -65 -90; 90 60 30 0 -30]
ser1 = [10 -15 -40 -65 -90];
ser2 = [90 60 30 0 -30];

ind = reshape(1:25, [5 ,5])

obsInfo = rlFiniteSetSpec([1:25]);
obsInfo.Name = 'observations';
obsInfo.Description = 'Servo 1, Servo 2';
numObservations = obsInfo.Dimension(1);

actInfo = rlFiniteSetSpec([1 2 3 4]'); %N S W E
actInfo.Name = 'Position Servo 1, Position Servo 2';
numActions = actInfo.Dimension(1);  


env = rlSimulinkEnv('Crawler_Simscape','Crawler_Simscape/RL Agent',...
    obsInfo,actInfo);

qTable = rlTable(getObservationInfo(env), getActionInfo(env));
tableRep = rlRepresentation(qTable);
tableRep.Options.LearnRate = 1;

agentOpts = rlQAgentOptions;
agentOpts.EpsilonGreedyExploration.Epsilon = 0.9;
agentOpts.EpsilonGreedyExploration.EpsilonMin = 0.05;
agentOpts.EpsilonGreedyExploration.EpsilonDecay = 0.01;
qAgent = rlQAgent(tableRep,agentOpts);

trainOpts = rlTrainingOptions;
%trainOpts.MaxStepsPerEpisode = 50000;
%trainOpts.MaxEpisodes= 5;
trainOpts.StopTrainingCriteria = "AverageReward";
trainOpts.StopTrainingValue = 2500;
trainOpts.ScoreAveragingWindowLength = 30;

 trainingStats = train(qAgent,env,trainOpts);
