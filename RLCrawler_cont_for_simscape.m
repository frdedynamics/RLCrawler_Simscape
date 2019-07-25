clear all


obsInfo =  rlNumericSpec([2 1],...
    'LowerLimit',[-90 -30]',...
    'UpperLimit',[10 90]');
obsInfo.Name = 'observations';
obsInfo.Description = 'Servo 1, Servo 2';
numObservations = obsInfo.Dimension(1);


actInfo = rlFiniteSetSpec([1 2 3 4]); %N S W E [1 2 3 4]'
actInfo.Name = 'Position Servo 1, Position Servo 2';
numActions = numel(actInfo);  

Ts = 1; %Sampletime
Tf = 100; %Simulationtime
env = rlSimulinkEnv('Crawler_Simscape','Crawler_Simscape/RL Agent',...
    obsInfo,actInfo);

%w0=[0, 0]';
w0=[0, 0, 0, 0]';
%w0=zeros(9,1);
%w0=zeros(14,1);
%w0=zeros(25,1);
%w0a=zeros(2,4);
w0a=[0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0];
%w0a=zeros(9,4);
%w0a=zeros(14,4);
%w0a=zeros(25,4);

repOpts = rlRepresentationOptions('LearnRate',0.1); %5e-5
critic = rlRepresentation(@linFeatures, w0, obsInfo, repOpts);
actor = rlRepresentation(@linFeatures, w0a, obsInfo, actInfo,repOpts);

agentOpts = rlACAgentOptions(...
    'SampleTime',Ts,...
    'EntropyLossWeight', 1);%,...
    %'NumStepsToLookAhead', 1);

agent = rlACAgent(actor, critic, agentOpts)
validateEnvironment(env)

maxsteps = ceil(Tf/Ts);
trainOpts = rlTrainingOptions;
trainOpts.MaxStepsPerEpisode = maxsteps;
trainOpts.MaxEpisodes= 500;
trainOpts.StopTrainingCriteria = "AverageReward";
trainOpts.StopTrainingValue = 200;
trainOpts.ScoreAveragingWindowLength = 30;
%trainOpts.SaveAgentCriteria = "EpisodeCount";
%trainOpts.SaveAgentValue = 3;
%trainOpts.StopOnError = "off";
%trainOpts.Plots = "none";
%trainOpts.Verbose = 1;

trainingStats = train(agent,env,trainOpts);
%generatePolicyFunction(agent)
