
obsInfo =  rlNumericSpec([2 1],...
    'LowerLimit',[-90 -30]',...
    'UpperLimit',[10 90]');
obsInfo.Name = 'observations';
obsInfo.Description = 'Servo 1, Servo 2';
numObservations = obsInfo.Dimension(1);


actInfo = rlFiniteSetSpec([1 2 3 4]); %N S W E [1 2 3 4]'
actInfo.Name = 'Position Servo 1, Position Servo 2';
numActions = numel(actInfo);  

env = rlSimulinkEnv('Crawler_Simscape','Crawler_Simscape/RL Agent',...
    obsInfo,actInfo);

w0=[0, 0, 0, 0]';
w0a=[0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0];
critic = rlRepresentation(@linFeatures, w0, obsInfo);
actor = rlRepresentation(@linFeatures, w0a, obsInfo, actInfo);


agentOpts = rlACAgentOptions;
% agentOpts.NumStepsToLookAhead = 8;

agent = rlACAgent(actor, critic, agentOpts)

trainOpts = rlTrainingOptions;
trainOpts.MaxStepsPerEpisode = 50;
trainOpts.MaxEpisodes= 500;
trainOpts.StopTrainingCriteria = "AverageReward";
trainOpts.StopTrainingValue = 2;
trainOpts.ScoreAveragingWindowLength = 30;

trainingStats = train(agent,env,trainOpts);
